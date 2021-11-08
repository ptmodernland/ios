//
//  KasbonViewModel.swift
//  Modernland Approval
//
//  Created by ITMLR-01 on 24/05/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class KasbonViewModel {
let apiHelper = ApiHelper()
//let username = UserDefaults().string(forKey: "username") ?? ""

    func getCounter(username: String,
                    onSuccess: @escaping (CounterKasbon) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.COUNTER_KASBON+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func postListKasbon(username: String,
                     onSuccess: @escaping ([ListKASBON]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_KASBON+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func getDetailKasbon(noKasbon: String,
                       onSuccess: @escaping (DetailKASBON) -> Void,
                       onError: @escaping (String) -> Void,
                       onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.GET_KASBON+"?noKasbon=\(noKasbon)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func approveKasbon(param: [String:Any],
                    onSuccess: @escaping (Status) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_KASBON,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func rejectKasbon(param: [String:Any],
                   onSuccess: @escaping (Status) -> Void,
                   onError: @escaping (String) -> Void,
                   onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.CANCEL_KASBON,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }

    func postListHistoryKasbon(username: String,
                            onSuccess: @escaping ([ListKASBON]) -> Void,
                            onError: @escaping (String) -> Void,
                            onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_HISTORY_KASBON+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
}
