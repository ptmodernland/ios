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
    //let username = UserDefaults().string(forKey: "username") ?? ""
    
    func getCounter(username: String,
                    onSuccess: @escaping (CounterIOM) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.COUNTER_MEMO+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    
    func postListIom(username: String,
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
    
    func postListHistoryIom(username: String,
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
    
    func getDetailRekomendasi(nomorMemo: String, approve: String, idIom: String, idKoordinasi: String,
                       onSuccess: @escaping (DetailKoordinasi) -> Void,
                       onError: @escaping (String) -> Void,
                       onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.GET_KOORDINASI+"?nomormemo=\(nomorMemo)&id=\(idIom)&username=\(approve)&id_kordinasi=\(idKoordinasi)",
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
    
    func getListHead(onSuccess: @escaping ([Head]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.getRequest(
            url: Constants.BASE_URL+Constants.LIST_HEAD,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func listKoordinasi(username: String,
                        onSuccess: @escaping ([ListKoordinasi]) -> Void,
                        onError: @escaping (String) -> Void,
                        onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_KOORDINASI+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func approveRekomendasi(param: [String:Any],
                    onSuccess: @escaping (Status) -> Void,
                    onError: @escaping (String) -> Void,
                    onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_APPROVE_KOORDINASI,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func rejectRekomendasi(param: [String:Any],
                   onSuccess: @escaping (Status) -> Void,
                   onError: @escaping (String) -> Void,
                   onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_CANCEL_KOORDINASI,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func prosesRekomendasi(param: [String:Any],
                   onSuccess: @escaping (Status) -> Void,
                   onError: @escaping (String) -> Void,
                   onFailed: @escaping (String) -> Void) {
        apiHelper.postRequest(
            url: Constants.BASE_URL+Constants.PROSES_KOORDINASI,
            body: param,
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }

    func getCounterKategori(username: String,
                            onSuccess: @escaping (CounterKateori) -> Void,
                            onError: @escaping (String) -> Void,
                            onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.COUNTER_KATEGORI+"?username=\(username)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }

    
    func postListKategoriIom(username: String,divisiID: String,
                     onSuccess: @escaping ([ListKategoriIOM]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_KATEGORI_MEMO+"?username=\(username)&divisi_id=\(divisiID)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
    func postListStatus(nomorMemo: String, idIom: String,
                     onSuccess: @escaping ([ListStatus]) -> Void,
                     onError: @escaping (String) -> Void,
                     onFailed: @escaping (String) -> Void) {
        apiHelper.postRequestList(
            url: Constants.BASE_URL+Constants.LIST_STATUS+"?nomorMemo=\(nomorMemo)&idIom=\(idIom)",
            body: ["":""],
            onSuccess: { response in onSuccess(response) },
            onError: { error in onError("\(error)") },
            onFailed: { failed in onFailed("\(failed)") }
        )
    }
    
}
