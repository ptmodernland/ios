//
//  IOMViewModel.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class IOMViewModel {
    
    let apiHelper = ApiHelper()
    let username = UserDefaults().string(forKey: "username") ?? ""
    
    func postListIom(body: [String:Any],
                     onSuccess: @escaping ([ListIOM]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_APPROVAL+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func postListHistoryIom(body: [String:Any],
                     onSuccess: @escaping ([ListIOM]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_MEMO+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func getDetailMemo(idIom: Int,
                     onSuccess: @escaping (DetailIOM) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.GET_MEMO+"?idiom=\(idIom)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func approveIom(param: [String:Any],
                     onSuccess: @escaping (Status) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_APPROVE,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func rejectIom(param: [String:Any],
                     onSuccess: @escaping (Status) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.CANCEL_MEMO,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
}
