//
//  ApiHelper.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 10/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiHelper: NSObject {
    
    static let instance = ApiHelper()
    
    private func defineMethod(method: String) -> HTTPMethod {
        switch method {
        case "GET":
            return .get
        case "POST":
            return .post
        case "PUT":
            return .put
        default:
            return .get
        }
    }
    
    private func cancelAllRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    private func pauseRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.suspend() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    
    private func resumeRequest() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.resume() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    
    public func getRequest<T: Codable>(url: String, onSuccess: @escaping (T) -> Void, onError: @escaping (String) -> Void, onFailed: @escaping (String) -> Void) {
        let headers: HTTPHeaders = []
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .failure(let error):
                onFailed(error.localizedDescription)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: value!)
                    onSuccess(result)
                } catch let error {
                    debugPrint(error)
                    onError("unexpected error: \(error)")
                }
            }
        }
    }
    
    public func postRequest<T: Codable>(url: String, body: Parameters, onSuccess: @escaping (T) -> Void, onError: @escaping (String) -> Void, onFailed: @escaping (String) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers: headers).response { response in
            switch response.result {
            case .failure(let error):
                onFailed(error.localizedDescription)
            case .success(let value):
                let json = JSON(value!)
                do {
                    let decoder = JSONDecoder()
                    let status = json["status"]
                    let message = json["pesan"]
                    if status == true {
                        let result = try decoder.decode(T.self, from: value!)
                        onSuccess(result)
                    } else {
                        //Print(message)
                        onFailed(message.stringValue)
                    }
                } catch let error {
                    debugPrint(error)
                    onError("unexpected error: \(error)")
                }
            }
        }
    }
    
    public func postRequestList<T: Codable>(url: String, body: Parameters, onSuccess: @escaping (T) -> Void, onError: @escaping (String) -> Void, onFailed: @escaping (String) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: URLEncoding.default, headers: headers).response { response in
            switch response.result {
            case .failure(let error):
                onFailed(error.localizedDescription)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: value!)
                    onSuccess(result)
                } catch let error {
                    debugPrint(error)
                    onError("unexpected error: \(error)")
                }
            }
        }
    }
}
 
