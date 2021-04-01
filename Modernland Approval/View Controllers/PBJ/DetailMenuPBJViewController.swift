//
//  DetailMenuPBJViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 09/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit
import QuickLook
import UITextView_Placeholder

class DetailMenuPBJViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!

    //Class Variable
    let vm = PBJViewModel()
    var assetPdf = ""
    var type = "approval"
    var noPermintaan = ""
    var pdfDownloaded = false
    var fromPushNotif = false
    lazy var previewItem = NSURL()
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblNama: UILabel!
    @IBOutlet weak var lblDepartemen: UILabel!
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var stackPdf: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "history" {
            lblTitle.text = "Menu History"
            stackButton.isHidden = true
        } else {
            lblTitle.text = "Menu Approval"
            stackButton.isHidden = false
        }
        btnBack.layer.cornerRadius = 6
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if type == "history" {
            getApiDetail()
        } else {
            getApiDetail()
        }
        makeRounded(view: btnBack)
    }
    
    func getApiDetail() {
        showLoading()
        vm.getDetailPbj(
            noPermintaan: noPermintaan,
            onSuccess: { response in
                self.hideLoading()
                print(response)
                
                self.lblDate.text = response.tanggal ?? ""
                self.lblNomor.text = response.nomor ?? "";
                self.lblDepartemen.text = response.departemen ?? "";
                self.lblNama.text = response.namaUser ?? "";
                self.btnFile.setTitle(response.attachments ?? "", for: .normal)
                print(response.attachments ?? "")
                self.assetPdf = response.attachments ?? ""
                if self.assetPdf == "" {
                    self.stackPdf.isHidden = true
                }
                self.textViewNotes.placeholder="Input Catatan Anda"
        },
            onError: { error in
                self.hideLoading()
                print(error)
                Toast.show(message: error, controller: self)
        },
            onFailed: { failed in
                self.hideLoading()
                print(failed)
                Toast.show(message: failed, controller: self)
        })
    }
    
    func apiApprovePbj(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "no_permintaan" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "ipaddres" : self.getIPAddress(),
            "passwordUser" : pin
            ] as [String : Any]
        vm.approvePbj(
            param: param,
            onSuccess: { response in
                self.navigationController?.popViewController(animated: true)
        }, onError: { error in
            print(error)
            Toast.show(message: error, controller: self)
        }, onFailed: { failed in
            print(failed)
            Toast.show(message: failed, controller: self)
        })
        self.view.endEditing(true)
    }
    
    func apiRejectPbj(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "no_permintaan" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "ipaddres" : self.getIPAddress(),
            "passwordUser" : pin
            ] as [String : Any]
        vm.rejectPbj(
            param: param,
            onSuccess: { response in
                self.navigationController?.popViewController(animated: true)
        }, onError: { error in
            print(error)
            Toast.show(message: error, controller: self)
        }, onFailed: { failed in
            print(failed)
            Toast.show(message: failed, controller: self)
        })
        self.view.endEditing(true)
    }
    
    
    func callAlertTextBox(type: String) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "\(type)", message: "Masukkan Pin Anda", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.isSecureTextEntry = true
            textField.delegate = self
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
            if type == "Approve" {
                self.apiApprovePbj(pin: textField?.text ?? "")
            } else {
                self.apiRejectPbj(pin: textField?.text ?? "")
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    func downloadPdf(completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        
        let itemUrl = URL(string: "https://approval.modernland.co.id/assets/file/\(assetPdf)")
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("\(assetPdf)")
        
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            debugPrint("The file already exists at path")
            completion(true, destinationUrl)
        } else {
            URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    print("File moved to documents folder")
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
    
    @IBAction func buttonApproveTap(_ sender: Any) {
            callAlertTextBox(type: "Approve")
    }
    
    @IBAction func buttonRejectTap(_ sender: Any) {
            callAlertTextBox(type: "Reject")
    }
    
    @IBAction func buttonDetailWebviewTap(_ sender: Any) {
        let vc = StoryboardScene.WebView.webViewViewController.instantiate()
        vc.url = "https://approval.modernland.co.id/permohonan_barang_jasa/views_permohonan/\(noPermintaan)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if fromPushNotif == true {
            goToHome()
        }
        else{
            back()
        }
    }
    
    
    @IBAction func pdfDownloadButtonTap(_ sender: Any) {
        if pdfDownloaded == false {
            self.downloadPdf(completion: {(success, fileLocationURL) in
                DispatchQueue.main.async {
                    if success {
                        self.previewItem = fileLocationURL! as NSURL
                        self.pdfDownloaded = true
                    } else {
                        Toast.show(message: "Gagal Unduh PDF", controller: self)
                    }
                }
            })
        } else {
            let previewController = QLPreviewController()
            previewController.dataSource = self
            self.present(previewController, animated: true, completion: nil)
        }
    }
}



extension DetailMenuPBJViewController : QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}
