//
//  SettingViewModel.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

class SettingViewModel {
    
    let apiHelper = ApiHelper()
    
    func postLogout(body: [String:Any],
                    onSuccess: @escaping (BaseResponse) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.LOGOUT,
            body: body,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func postChangePassword(body: [String:Any],
                    onSuccess: @escaping (BaseResponse) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.CHANGE_PASSWORD,
            body: body,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
}
