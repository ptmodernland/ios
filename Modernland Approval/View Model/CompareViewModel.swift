//
//  IOMViewModel.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class CompareViewModel {
    
    let apiHelper = ApiHelper()
    let username = UserDefaults().string(forKey: "username") ?? ""
    
    func getCounter(onSuccess: @escaping (CounterPBJ) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.COUNTER_COMPARE+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    func postListCompare(body: [String:Any],
                     onSuccess: @escaping ([ListCompare]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_COMPARE+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func getDetailCompare(idCompare: Int,
                       onSuccess: @escaping (DetailCompare) -> Void,
                       onError: @escaping (String) -> Void,
                       onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.GET_COMPARE+"?idcompare=\(idCompare)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func approveCompare(param: [String:Any],
                    onSuccess: @escaping (Status) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_COMPARE,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func rejectCompare(param: [String:Any],
                   onSuccess: @escaping (Status) -> Void,
                   onError: @escaping (String) -> Void,
                   onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.CANCEL_COMPARE,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }

    func postListHistoryCompare(body: [String:Any],
                            onSuccess: @escaping ([ListCompare]) -> Void,
                            onError: @escaping (String) -> Void,
                            onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_HISTORY_COMPARE+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
}
