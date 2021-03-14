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

    //IOM
    static let LIST_APPROVAL = "/androidiom/list_approve.jsp" //waiting approval
    static let GET_MEMO = "/androidiom/get_memo.jsp" //detail
    static let LIST_MEMO = "/androidiom/list_memo.jsp" //history
    static let CANCEL_MEMO = "/androidiom/proses_cancel_memo.jsp"
    static let PROSES_APPROVE = "/androidiom/proses_approve.jsp"

    //COUNTER
    static let COUNTER_ALL = "/androidiom/counter_all.jsp"
    static let COUNTER_MEMO = "/androidiom/counter_memo.jsp"

}
