//
//  DetailIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class DetailIOMViewController: BaseViewController {
    
    let vm = IOMViewModel()
    var idIom = 0
    
    @IBOutlet weak var lblRecipient: UILabel!
    @IBOutlet weak var lblCc: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var textViewNotes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiDetail()
        // Do any additional setup after loading the view.
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
    
    func callAlertTextBox() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Masukkan Pin Anda", message: "", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonApproveTap(_ sender: Any) {
        callAlertTextBox()
    }
    
    @IBAction func buttonRejectTap(_ sender: Any) {
        callAlertTextBox()
    }
}
