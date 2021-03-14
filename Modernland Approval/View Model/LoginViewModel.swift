//
//  LoginViewModel.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 10/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let apiHelper = ApiHelper()
    
    func postLogin(body: [String:Any],
                   onSuccess: @escaping (LoginSuccess) -> Void,
                   onError: @escaping (String) -> Void,
                   onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.LOGIN,
            body: body,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
}
