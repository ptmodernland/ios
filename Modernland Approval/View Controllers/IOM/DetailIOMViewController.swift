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
    @IBOutlet weak var lblTxtTitle: UILabel!
    //Class Variable
    let vm = IOMViewModel()
    var idIom = 0
    var assetPdf = ""
    var type = "approval"
    var nomorMemo = ""
    var idKoordinasi = ""
    var pdfDownloaded = false
    
    var fromPushNotif = false
    
    lazy var previewItem = NSURL()
    
    @IBOutlet var detailViewIOM: UIView!
    
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
    @IBOutlet weak var lblTxtRecipient: UILabel!
    @IBOutlet weak var lblTxtDownloadFile: UILabel!
    @IBOutlet weak var lblTxtViewDetail: UILabel!
    @IBOutlet weak var btnKlikDisini: UIButton!
    @IBOutlet weak var lblTxtFrom: UILabel!
    @IBOutlet weak var lblTxtCc: UILabel!
    @IBOutlet weak var lblTxtDate: UILabel!
    @IBOutlet weak var lblTxtNomor: UILabel!
    @IBOutlet weak var lblTxtCategory: UILabel!
    @IBOutlet weak var lblTxtAbout: UILabel!
    @IBOutlet weak var lblTxtDownloadPdf: UILabel!
    @IBOutlet weak var lblTxtCatatan: UILabel!
    
    @IBOutlet var myConstraint1 : NSLayoutConstraint!
    @IBOutlet var myConstraint2 : NSLayoutConstraint!
    @IBOutlet var myConstraint3 : NSLayoutConstraint!
    @IBOutlet var myConstraint4 : NSLayoutConstraint!
    @IBOutlet var myConstraint5 : NSLayoutConstraint!
    @IBOutlet var myConstraint6 : NSLayoutConstraint!
    @IBOutlet var myConstraint7 : NSLayoutConstraint!
    @IBOutlet var myConstraint8 : NSLayoutConstraint!
    @IBOutlet var myConstraint9 : NSLayoutConstraint!
    @IBOutlet var myConstraint10 : NSLayoutConstraint!
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnApprove: UIButton!
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
        btnBack.layer.cornerRadius = 6
        self.hideKeyboardWhenTappedAround()
        self.settingView()
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
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "id_iom" : idIom,
            "mac" : macAddress,
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
        self.view.endEditing(true)
    }
    
    func apiRejectIom(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "id_iom" : idIom,
            "mac" : macAddress,
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
        self.view.endEditing(true)
    }
    
    func apiApproveRekomendasi() {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id" : idIom,
            "id_kordinasi" : idKoordinasi,
            "id_user" : idUser ?? "",
            "ipaddres" : self.getIPAddress(),
            "mac" : macAddress,
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
        self.view.endEditing(true)
    }
    
    func apiRejectRekomendasi() {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id" : idIom,
            "id_kordinasi" : idKoordinasi,
            "id_user" : idUser ?? "",
            "ipaddres" : self.getIPAddress(),
            "mac" : macAddress,
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
    
    func settingView() {
        if (self.view.frame.width == 320) {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 12)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 12)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 12)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 12)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 12)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 12)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 12)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 12)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 12)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 12)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 12)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 12)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 12)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 12)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 12)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 12)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.myConstraint1.constant = 130
            self.myConstraint2.constant = 130
            self.myConstraint3.constant = 130
            self.myConstraint4.constant = 130
            self.myConstraint5.constant = 130
            self.myConstraint6.constant = 130
            self.myConstraint7.constant = 130
            self.myConstraint8.constant = 130
            self.myConstraint9.constant = 130
            self.myConstraint10.constant = 130
            self.detailViewIOM.layoutIfNeeded()
        } else if (self.view.frame.width == 375) {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 14)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 14)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 14)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 14)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 14)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 14)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 14)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 14)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 14)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 14)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 14)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 14)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 14)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 14)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 14)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 14)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.myConstraint1.constant = 130
            self.myConstraint2.constant = 130
            self.myConstraint3.constant = 130
            self.myConstraint4.constant = 130
            self.myConstraint5.constant = 130
            self.myConstraint6.constant = 130
            self.myConstraint7.constant = 130
            self.myConstraint8.constant = 130
            self.myConstraint9.constant = 130
            self.myConstraint10.constant = 130
            self.detailViewIOM.layoutIfNeeded()
        } else if (self.view.frame.width == 414) {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 18)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 18)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 18)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 18)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 18)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 18)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 18)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 18)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 18)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 18)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 18)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 18)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 18)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 18)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 18)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 18)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 18)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.myConstraint1.constant = 130
            self.myConstraint2.constant = 130
            self.myConstraint3.constant = 130
            self.myConstraint4.constant = 130
            self.myConstraint5.constant = 130
            self.myConstraint6.constant = 130
            self.myConstraint7.constant = 130
            self.myConstraint8.constant = 130
            self.myConstraint9.constant = 130
            self.myConstraint10.constant = 130
            self.detailViewIOM.layoutIfNeeded()
        } else if (self.view.frame.width == 768) {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 20)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 20)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 20)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 20)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 20)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 20)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 20)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 20)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 20)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 20)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 20)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 20)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 20)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 20)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 20)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 20)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 20)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.myConstraint10.constant = 350
            self.detailViewIOM.layoutIfNeeded()
        } else if (self.view.frame.width == 1024) {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 25)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 25)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 25)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 25)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 25)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 25)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 25)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.myConstraint10.constant = 350
            self.detailViewIOM.layoutIfNeeded()
        } else {
            self.lblRecipient.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblCc.font = UIFont(name: self.lblTitle.font.fontName, size: 25)
            self.lblFrom.font = UIFont(name: self.lblFrom.font.fontName, size: 25)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblCategory.font = UIFont(name: self.lblCategory.font.fontName, size: 25)
            self.lblAbout.font = UIFont(name: self.lblAbout.font.fontName, size: 25)
            self.lblTxtRecipient.font = UIFont(name: self.lblTxtRecipient.font.fontName, size: 25)
            self.lblTxtCc.font = UIFont(name: self.lblTxtCc.font.fontName, size: 25)
            self.lblTxtFrom.font = UIFont(name: self.lblTxtFrom.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblTxtCategory.font = UIFont(name: self.lblTxtCategory.font.fontName, size: 25)
            self.lblTxtAbout.font = UIFont(name: self.lblTxtAbout.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnRecommend.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.myConstraint10.constant = 350
            self.detailViewIOM.layoutIfNeeded()
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
        if fromPushNotif == true {
            goToHome()
        }
        else{
            back()
        }
        
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
