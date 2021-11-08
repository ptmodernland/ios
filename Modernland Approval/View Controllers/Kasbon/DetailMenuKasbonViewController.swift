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

class DetailMenuKasbonViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbltxtTitle: UILabel!
    
    //Class Variable
    let vm = KasbonViewModel()
    var assetPdf = ""
    var type = "approval"
    var noKasbon = ""
    var idKasbon = ""
    var pdfDownloaded = false
    var fromPushNotif = false
    lazy var previewItem = NSURL()
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblNama: UILabel!
    @IBOutlet weak var lblDepartemen: UILabel!
    @IBOutlet weak var lblKeterangan: UILabel!
    @IBOutlet weak var lblJumlah: UILabel!
    
    @IBOutlet weak var lblTxtDate: UILabel!
    @IBOutlet weak var lblTxtNomor: UILabel!
    @IBOutlet weak var lblTxtNama: UILabel!
    @IBOutlet weak var lblTxtDepartemen: UILabel!
    @IBOutlet weak var lblTxtKeterangan: UILabel!
    @IBOutlet weak var lblTxtJumlah: UILabel!
    
    @IBOutlet weak var btnFile: UIButton!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var stackPdf: UIStackView!
    
    @IBOutlet weak var lblTxtViewDetail: UILabel!
    @IBOutlet weak var lblTxtDownloadFile: UILabel!
    @IBOutlet weak var lblTxtCatatan: UILabel!
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
    
    @IBOutlet var detailViewKasbon: UIView!
    
    @IBOutlet weak var btnApprove: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
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
        self.configScreen()
        
        textViewNotes.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func configScreen(){
        if (self.view.frame.width == 320) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 12)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 12)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 12)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 12)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 12)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 12)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 12)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 12)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 12)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 12)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 12)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 12)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 12)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
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
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 375) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 14)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 14)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 14)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 14)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 14)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 14)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 14)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 14)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 14)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 14)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 14)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 14)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 14)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
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
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 390) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 14)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 14)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 14)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 14)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 14)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 14)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 14)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 14)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 14)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 14)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 14)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 14)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 14)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
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
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 414) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 16)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 16)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 16)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 16)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 16)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 16)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 16)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 16)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 16)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 16)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 16)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 16)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 16)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 16)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 16)
            self.myConstraint1.constant = 150
            self.myConstraint2.constant = 150
            self.myConstraint3.constant = 150
            self.myConstraint4.constant = 150
            self.myConstraint5.constant = 150
            self.myConstraint6.constant = 150
            self.myConstraint7.constant = 150
            self.myConstraint8.constant = 150
            self.myConstraint9.constant = 150
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 428) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 16)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 16)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 16)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 16)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 16)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 16)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 16)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 16)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 16)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 16)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 16)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 16)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 16)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 16)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 16)
            self.myConstraint1.constant = 150
            self.myConstraint2.constant = 150
            self.myConstraint3.constant = 150
            self.myConstraint4.constant = 150
            self.myConstraint5.constant = 150
            self.myConstraint6.constant = 150
            self.myConstraint7.constant = 150
            self.myConstraint8.constant = 150
            self.myConstraint9.constant = 150
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 768) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 18)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 18)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 18)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 18)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 18)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 18)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 18)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 18)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 18)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 18)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 18)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 18)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 18)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 18)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 18)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 18)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.detailViewKasbon.layoutIfNeeded()
        } else if (self.view.frame.width == 1024) {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 52)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 25)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 25)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 25)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.detailViewKasbon.layoutIfNeeded()
        } else {
            self.lbltxtTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
            self.lblDate.font = UIFont(name: self.lblDate.font.fontName, size: 25)
            self.lblNomor.font = UIFont(name: self.lblNomor.font.fontName, size: 25)
            self.lblNama.font = UIFont(name: self.lblNama.font.fontName, size: 25)
            self.lblDepartemen.font = UIFont(name: self.lblDepartemen.font.fontName, size: 25)
            self.lblTxtDate.font = UIFont(name: self.lblTxtDate.font.fontName, size: 25)
            self.lblTxtNomor.font = UIFont(name: self.lblTxtNomor.font.fontName, size: 25)
            self.lblTxtNama.font = UIFont(name: self.lblTxtNama.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.lblTxtCatatan.font = UIFont(name: self.lblTxtCatatan.font.fontName, size: 25)
            self.btnFile.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnKlikDisini.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnApprove.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.btnReject.titleLabel?.font =  UIFont(name: "Helvetica", size: 25)
            self.lblTxtViewDetail.font = UIFont(name: self.lblTxtViewDetail.font.fontName, size: 25)
            self.lblTxtDownloadFile.font = UIFont(name: self.lblTxtDownloadFile.font.fontName, size: 25)
            self.lblJumlah.font = UIFont(name: self.lblJumlah.font.fontName, size: 25)
            self.lblKeterangan.font = UIFont(name: self.lblKeterangan.font.fontName, size: 25)
            self.lblTxtJumlah.font = UIFont(name: self.lblTxtJumlah.font.fontName, size: 25)
            self.lblTxtDepartemen.font = UIFont(name: self.lblTxtDepartemen.font.fontName, size: 25)
            self.myConstraint1.constant = 350
            self.myConstraint2.constant = 350
            self.myConstraint3.constant = 350
            self.myConstraint4.constant = 350
            self.myConstraint5.constant = 350
            self.myConstraint6.constant = 350
            self.myConstraint7.constant = 350
            self.myConstraint8.constant = 350
            self.myConstraint9.constant = 350
            self.detailViewKasbon.layoutIfNeeded()
            }
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getApiDetail() {
        showLoading()
        vm.getDetailKasbon(
            noKasbon: noKasbon,
            onSuccess: { response in
                self.hideLoading()
                print(response)
                
                self.lblDate.text = response.tanggal ?? ""
                self.lblNomor.text = response.nomor ?? "";
                self.lblDepartemen.text = response.departemen ?? "";
                self.lblNama.text = response.namaUser ?? "";
                self.lblJumlah.text = response.jumlah ?? "";
                self.lblKeterangan.text = response.keterangan ?? "";
                self.btnFile.setTitle(response.attachments ?? "", for: .normal)
                self.lblKeterangan.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.lblKeterangan.numberOfLines = 0
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
    
    func apiApproveKasbon(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "noKasbon" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "ipaddres" : self.getIPAddress(),
            "macaddress" : macAddress,
            "passwordUser" : pin
            ] as [String : Any]
        vm.approveKasbon(
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
    
    func apiRejectKasbon(pin: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        
        let param = [
            "noKasbon" : self.lblNomor.text ?? "",
            "id_user" : idUser ?? "",
            "komen" : self.textViewNotes.text ?? "",
            "ipaddres" : self.getIPAddress(),
            "macaddress" : macAddress,
            "passwordUser" : pin
            ] as [String : Any]
        vm.rejectKasbon(
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
                self.apiApproveKasbon(pin: textField?.text ?? "")
            } else {
                self.apiRejectKasbon(pin: textField?.text ?? "")
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
        vc.url = "https://approval.modernland.co.id/kasbon/view_mobile/\(idKasbon)"
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
       // if pdfDownloaded == false {
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



extension DetailMenuKasbonViewController : QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}