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

class DetailCompareViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate  {
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    @IBOutlet var detailViewCompare: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTxtTitle: UILabel!
    //Class Variable
    let vm = CompareViewModel()
    
    var assetPdf = ""
    var type = "approval"
    var idCompare = 0
    var nomorRef=""
    var pdfDownloaded = false
    var fromPushNotif = false
    
    lazy var previewItem = NSURL()
    
    @IBOutlet weak var lblAdvance: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var lblPajakReklame: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var btnRef: UIButton!
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var stackPdf: UIStackView!
    @IBOutlet weak var lblTxtAdvance: UILabel!
    @IBOutlet weak var lblTxtProgress: UILabel!
    @IBOutlet weak var lblTxtPajakReklame: UILabel!
    @IBOutlet weak var lblTxtDesc: UILabel!
    @IBOutlet weak var lblTxtDate: UILabel!
    @IBOutlet weak var lblTxtNomor: UILabel!
    @IBOutlet weak var lblTxtNoRef: UILabel!
    @IBOutlet weak var lblTxtDepartemen: UILabel!
    @IBOutlet weak var lblTxtViewDetail: UILabel!
    @IBOutlet weak var lblTxtDownloadFile: UILabel!
    @IBOutlet weak var lblTxtCatatan: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDepartemen: UILabel!
    @IBOutlet weak var btnApprove: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnKlikDisini: UIButton!
    
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
    @IBOutlet var myConstraint11 : NSLayoutConstraint!
    
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
        if (self.view.frame.width == 320) {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 12)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 12)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 12)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 12)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 12)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 12)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 12)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 12)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 12)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 12)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 12)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 12)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 12)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 12)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 12)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 12)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 12)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 12)
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
            self.myConstraint11.constant = 130
            self.detailViewCompare.layoutIfNeeded()
        } else if (self.view.frame.width == 375) {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 14)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 14)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 14)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 14)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 14)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 14)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 14)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 14)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 14)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 14)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 14)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 14)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 14)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 14)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 14)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 14)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 14)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 14)
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
            self.myConstraint11.constant = 130
            self.detailViewCompare.layoutIfNeeded()
        } else if (self.view.frame.width == 414) {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 16)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 16)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 16)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 16)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 16)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 16)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 16)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 16)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 16)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 16)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 16)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 16)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 16)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 16)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 16)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 16)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 16)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 16)
            self.myConstraint1.constant = 150
            self.myConstraint2.constant = 150
            self.myConstraint3.constant = 150
            self.myConstraint4.constant = 150
            self.myConstraint5.constant = 150
            self.myConstraint6.constant = 150
            self.myConstraint7.constant = 150
            self.myConstraint8.constant = 150
            self.myConstraint9.constant = 150
            self.myConstraint10.constant = 150
            self.myConstraint11.constant = 150
            self.detailViewCompare.layoutIfNeeded()
        } else if (self.view.frame.width == 768) {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 18)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 18)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 18)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 18)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 18)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 18)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 18)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 18)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 18)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 18)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 18)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 18)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 18)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 18)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 18)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 18)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 18)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 18)
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
            self.myConstraint11.constant = 350
            self.detailViewCompare.layoutIfNeeded()
        } else if (self.view.frame.width == 1024) {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 52)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 25)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 25)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 25)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 25)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 25)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 25)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 25)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
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
            self.myConstraint11.constant = 350
            self.detailViewCompare.layoutIfNeeded()
        } else {
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 52)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblAdvance.font = UIFont(name: self.lblAdvance.font.fontName, size: 25)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblProgress.font = UIFont(name: self.lblProgress.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.lblPajakReklame.font = UIFont(name: self.lblPajakReklame.font.fontName, size: 25)
            self.lblDesc.font = UIFont(name: self.lblDesc.font.fontName, size: 25)
            self.lblTxtAdvance.font = UIFont(name: self.lblTxtAdvance.font.fontName, size: 25)
            self.lblTxtProgress.font = UIFont(name: self.lblTxtProgress.font.fontName, size: 25)
            self.lblTxtPajakReklame.font = UIFont(name: self.lblTxtPajakReklame.font.fontName, size: 25)
            self.lblTxtDesc.font = UIFont(name: self.lblTxtDesc.font.fontName, size: 25)
            self.lblTxtNoRef.font = UIFont(name: self.lblTxtNoRef.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnRef.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
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
            self.myConstraint11.constant = 350
            self.detailViewCompare.layoutIfNeeded()
        }
        self.hideKeyboardWhenTappedAround()
        textViewNotes.delegate = self

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
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
        vm.getDetailCompare(
            idCompare: idCompare,
            onSuccess: { response in
                self.hideLoading()
                print(response)
                let modifiedFontString = "<li style='font-size:18px'>"+response.descCompare!+"</li>"
                let data_response = modifiedFontString.data(using: .utf8)!
                
                let attributedString = try? NSAttributedString(
                    data: data_response,
                    options: [.documentType: NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
                
                self.lblAdvance.text = response.advancePayment ?? ""
                self.lblProgress.text = response.progresPayment ?? ""
                self.lblPajakReklame.text = response.pajakReklame ?? ""
                self.lblDepartemen.text = response.deptUser ?? ""
                self.lblDate.text = response.tanggal ?? ""
                self.lblNomor.text = response.nomor ?? ""
                self.lblDesc.text = response.descCompare ?? ""
                self.lblDesc.attributedText = attributedString
                self.btnRef.setTitle(response.noRef ?? "", for: .normal)
                self.btnFile.setTitle(response.attach ?? "", for: .normal)
                self.assetPdf = response.attach ?? ""
                self.nomorRef = response.noRef ?? ""
                
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
  
    func apiApproveCompare(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "macaddress" : macAddress,
            "ipaddres" : self.getIPAddress(),
            "passwordUser" : pin
            ] as [String : Any]
        vm.approveCompare(
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
    
    func apiRejectCompare(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "nomor" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "ipaddres" : self.getIPAddress(),
            "komen" : self.textViewNotes.text ?? "",
            "macaddress" : macAddress,
            "passwordUser" : pin
            ] as [String : Any]
        vm.rejectCompare(
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
                self.apiApproveCompare(pin: textField?.text ?? "")
            } else {
                self.apiRejectCompare(pin: textField?.text ?? "")
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
        vc.url = "https://approval.modernland.co.id/compare/views_mobile/\(idCompare)"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func buttonDetailWebRefviewTap(_ sender: Any) {
        let vc = StoryboardScene.WebView.webViewViewController.instantiate()
        vc.url = "https://approval.modernland.co.id/compare/views_mobile_pr/\(nomorRef)"
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
        //if pdfDownloaded == false {
        self.showLoading()
            self.downloadPdf(completion: {(success, fileLocationURL) in
                DispatchQueue.main.async {
                    if success {
                        Toast.show(message: "File PDF Berhasil Unduh", controller: self)
                        self.previewItem = fileLocationURL! as NSURL
                        let previewController = QLPreviewController()
                        previewController.dataSource = self
                        self.present(previewController, animated: true, completion: nil)
                        self.hideLoading()
                    } else {
                        Toast.show(message: "Gagal Unduh PDF", controller: self)
                        self.hideLoading()
                    }
                }
            })
        /*} else {
            let previewController = QLPreviewController()
            previewController.dataSource = self
            self.present(previewController, animated: true, completion: nil)
        }*/
    }
    
}


extension DetailCompareViewController : QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}

