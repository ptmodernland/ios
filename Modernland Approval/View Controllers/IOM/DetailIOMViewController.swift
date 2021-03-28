//
//  DetailIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit
import QuickLook
import UITextView_Placeholder

class DetailIOMViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    //Class Variable
    let vm = IOMViewModel()
    var idIom = 0
    var assetPdf = ""
    var type = "approval"
    var nomorMemo = ""
    var idKoordinasi = ""
    var pdfDownloaded = false
    lazy var previewItem = NSURL()
    
    @IBOutlet weak var lblRecipient: UILabel!
    @IBOutlet weak var lblCc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var stackPdf: UIStackView!
    @IBOutlet weak var btnRecommend: UIButton!
    @IBOutlet weak var btnBack: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "history" {
            lblTitle.text = "Menu History"
            stackButton.isHidden = true
        } else if type == "rekomendasi"  {
            lblTitle.text = "Menu Rekomendasi"
            btnRecommend.isHidden = true
        } else {
            lblTitle.text = "Menu Approval"
            stackButton.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if type == "history" {
            getApiDetail()
        } else if type == "rekomendasi"  {
            getApiDetailRekomendasi()
        } else {
            getApiDetail()
        }
        makeRounded(view: btnBack)
    }
    
    func getApiDetail() {
        showLoading()
        vm.getDetailMemo(
            idIom: idIom,
            onSuccess: { response in
                self.hideLoading()
                print(response)
                self.lblRecipient.text = response.kepada ?? ""
                self.lblCc.text = response.cc ?? ""
                self.lblFrom.text = response.dari ?? ""
                self.lblDate.text = response.tanggal ?? ""
                self.lblNomor.text = response.nomor ?? ""
                self.lblCategory.text = response.kategoriIom ?? ""
                self.lblAbout.text = response.perihal ?? ""
                self.btnFile.setTitle(response.attachments ?? "", for: .normal)
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
    
    func getApiDetailRekomendasi() {
        showLoading()
        vm.getDetailRekomendasi(
            nomorMemo: nomorMemo,
            idIom: String(idIom),
            idKoordinasi: idKoordinasi,
            onSuccess: { response in
                self.hideLoading()
                print(response)
                self.lblRecipient.text = response.kepada ?? ""
                self.lblCc.text = response.cc ?? ""
                self.lblFrom.text = response.dari ?? ""
                self.lblDate.text = response.tanggal ?? ""
                self.lblNomor.text = response.nomor ?? ""
                self.lblAbout.text = response.perihal ?? ""
                self.btnFile.setTitle(response.attachments ?? "", for: .normal)
                self.assetPdf = response.attachments ?? ""
                if self.assetPdf == "" {
                    self.stackPdf.isHidden = true
                }
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
    
    func apiApproveIom(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "id_iom" : idIom,
            "passwordUser" : pin
            ] as [String : Any]
        vm.approveIom(
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
    }
    
    func apiRejectIom(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "id_iom" : idIom,
            "passwordUser" : pin
            ] as [String : Any]
        vm.rejectIom(
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
    }
    
    func apiApproveRekomendasi() {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id" : idIom,
            "id_kordinasi" : idKoordinasi,
            "id_user" : idUser ?? "",
            "ipaddres" : self.getIPAddress(),
            "komen" : self.textViewNotes.text ?? ""
            ] as [String : Any]
        vm.approveRekomendasi(
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
    }
    
    func apiRejectRekomendasi() {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id" : idIom,
            "id_kordinasi" : idKoordinasi,
            "id_user" : idUser ?? "",
            "ipaddres" : self.getIPAddress(),
            "komen" : self.textViewNotes.text ?? ""
            ] as [String : Any]
        vm.rejectRekomendasi(
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
                self.apiApproveIom(pin: textField?.text ?? "")
            } else {
                self.apiRejectIom(pin: textField?.text ?? "")
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
        if type == "rekomendasi" {
            apiApproveRekomendasi()
        } else {
            callAlertTextBox(type: "Approve")
        }
    }
    
    @IBAction func buttonRejectTap(_ sender: Any) {
        if type == "rekomendasi" {
            apiRejectRekomendasi()
        } else {
            callAlertTextBox(type: "Reject")
        }
    }
    
    @IBAction func buttonDetailWebviewTap(_ sender: Any) {
        let vc = StoryboardScene.WebView.webViewViewController.instantiate()
        vc.url = "https://approval.modernland.co.id/memo/view_mobile/\(idIom)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonRecommendationTap(_ sender: Any) {
        let vc = StoryboardScene.IOM.listHeadKoordinasiViewController.instantiate()
        vc.idIom = String(idIom)
        vc.nomor = nomorMemo
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func backButtonTap(_ sender: Any) {
        back()
    }
    
}


extension DetailIOMViewController : QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}
