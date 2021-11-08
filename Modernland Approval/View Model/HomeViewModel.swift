//
//  HomeViewModel.swift
//  Modernland Approval
//
//  Created by ITMLR-01 on 11/8/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    let apiHelper = ApiHelper()
    //let username = UserDefaults().string(forKey: "username") ?? ""

    func getCounter(username: String,
                    onSuccess: @escaping ([CounterALL]) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.COUNTER_ALL+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }

}
