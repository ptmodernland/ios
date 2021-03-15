//
//  DetailIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class DetailIOMViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    let vm = IOMViewModel()
    var idIom = 0
    var assetPdf = ""
    var type = "approval"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiDetail()
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
        getApiDetail()
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
    
    @IBAction func buttonApproveTap(_ sender: Any) {
        callAlertTextBox(type: "Approve")
    }
    
    @IBAction func buttonRejectTap(_ sender: Any) {
        callAlertTextBox(type: "Reject")
    }
    
    @IBAction func buttonDetailWebviewTap(_ sender: Any) {
        let vc = StoryboardScene.WebView.webViewViewController.instantiate()
        vc.url = "https://approval.modernland.co.id/memo/view_mobile/\(idIom)"
        //        vc.url = "https://approval.modernland.co.id/assets/file/\(assetPdf)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonRecommendationTap(_ sender: Any) {
        let vc = StoryboardScene.IOM.listHeadKoordinasiViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
