//
//  Constants.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 10/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class Constants {

    //BASE URL
    static let BASE_URL = "https://approval.modernland.co.id"
    
    //ENDPOINT
    //USER
    static let LOGIN = "/androidiom/proses_login.jsp"
    static let LOGOUT = "/androidiom/proses_logout.jsp"
    static let CHANGE_PASSWORD = "/androidiom/proses_change_password.jsp"

    //IOM
    static let LIST_APPROVAL = "/androidiom/list_approve.jsp" //waiting approval
    static let GET_MEMO = "/androidiom/get_memo.jsp" //detail
    static let LIST_MEMO = "/androidiom/list_memo.jsp" //history
    static let CANCEL_MEMO = "/androidiom/proses_cancel_memo.jsp"
    static let PROSES_APPROVE = "/androidiom/proses_approve.jsp"
    static let LIST_KATEGORI_MEMO = "/androidiom/list_approve_kategori.jsp" //history

    //Compare
    static let LIST_COMPARE = "/androidiom/list_approve_compare.jsp" //waiting approval
    static let GET_COMPARE = "/androidiom/get_compare.jsp" //detail
    static let LIST_HISTORY_COMPARE = "/androidiom/list_compare.jsp" //history
    static let CANCEL_COMPARE = "/androidiom/proses_cancel_compare.jsp"
    static let PROSES_COMPARE = "/androidiom/proses_approve_compare.jsp"
    
    //PBJ
    static let LIST_PERMOHONAN = "/androidiom/list_approve_pbj.jsp" //waiting approval
    static let GET_PBJ = "/androidiom/get_permohonan.jsp" //detail
    static let LIST_PBJ = "/androidiom/list_pbj.jsp" //history
    static let CANCEL_PBJ = "/androidiom/proses_cancel_pbj.jsp"
    static let PROSES_PBJ = "/androidiom/proses_approve_pbj.jsp"
    
    
    //COUNTER
    static let COUNTER_ALL = "/androidiom/counter_all.jsp"
    static let COUNTER_MEMO = "/androidiom/counter_memo.jsp"
    static let COUNTER_PBJ = "/androidiom/counter_permohonan.jsp"
    static let COUNTER_COMPARE = "/androidiom/counter_compare.jsp"
    static let COUNTER_KATEGORI = "/androidiom/counter_kategori.jsp"

    //REKOMENDASI
    static let LIST_HEAD = "/androidiom/get_head.jsp"
    static let PROSES_KOORDINASI = "/androidiom/proses_kordinasi.jsp"
    static let LIST_KOORDINASI = "/androidiom/list_kordinasi.jsp"
    static let GET_KOORDINASI = "/androidiom/get_kordinasi.jsp"
    static let PROSES_APPROVE_KOORDINASI = "/androidiom/proses_approve_kordinasi.jsp"
    static let PROSES_CANCEL_KOORDINASI = "/androidiom/proses_cancel_kordinasi.jsp"
}
