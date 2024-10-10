//
//  LPRequsetManager.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit
import Moya
import SwiftyJSON
import RxSwift

enum APIService {
    case requestAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method)
    case uploadImageAPI(params: [String: Any]?, pageUrl: String, data: Data, method: Moya.Method)
    case uploadDataAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method)
}

extension APIService: TargetType {
    var baseURL: URL {
        let baseUrl = RePinJieURL.appendQueryParameters(urlString: BASE_URL, parameters: LPLoginInfo.getLogiInfo()) ?? ""
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .requestAPI(_, let pageUrl, _), .uploadImageAPI(_, let pageUrl, _, _), .uploadDataAPI(_, let pageUrl, _):
            return pageUrl
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestAPI(_, _, let method),
                .uploadImageAPI(_, _, _, let method),
                .uploadDataAPI(_, _, let method):
            return method
        }
    }
    
    var task: Task {
        switch self {
        case .requestAPI(let params, _, _):
            return .requestParameters(parameters: params ?? [:], encoding: URLEncoding.default)
            
        case .uploadImageAPI(let params, _, let data, _):
            var formData = [MultipartFormData]()
            formData.append(MultipartFormData(provider: .data(data), name: "shock", fileName: "shock.png", mimeType: "image/png"))
            if let params = params {
                for (key, value) in params {
                    if let value = value as? String, let data = value.data(using: .utf8) {
                        formData.append(MultipartFormData(provider: .data(data), name: key))
                    }
                }
            }
            return .uploadMultipart(formData)
            
        case .uploadDataAPI(let params, _, _):
            var formData = [MultipartFormData]()
            if let params = params {
                for (key, value) in params {
                    if let value = value as? String, let data = value.data(using: .utf8) {
                        formData.append(MultipartFormData(provider: .data(data), name: key))
                    }
                }
            }
            return .uploadMultipart(formData)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Connection": "keep-alive",
            "Content-Type": "application/x-www-form-urlencoded;text/javascript;text/json;text/plain;multipart/form-data"
        ]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

class LPRequestManager: NSObject {
    
    private let provider = MoyaProvider<APIService>()
    
    private func requestData(target: APIService, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSON(data: response.data)
                    let baseModel = BaseModel(json: json)
                    self.handleResponse(baseModel: baseModel, completion: completion)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleResponse(baseModel: BaseModel, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        let frown = baseModel.frown ?? ""
        if baseModel.hitch == 0 || baseModel.hitch == 00 {
            completion(.success(baseModel))
        }else if baseModel.hitch == -2 {
            ViewCycleManager.hideCycView()
            ToastUtility.showToast(message: frown)
        }else {
            ViewCycleManager.hideCycView()
            ToastUtility.showToast(message: frown)
        }
    }
    
    func requestAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        requestData(target: .requestAPI(params: params, pageUrl: pageUrl, method: method), completion: completion)
    }
    
    func uploadDataAPI(params: [String: Any]?, pageUrl: String, method: Moya.Method, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        requestData(target: .requestAPI(params: params, pageUrl: pageUrl, method: method), completion: completion)
    }
    
    func uploadImageAPI(params: [String: Any]?, pageUrl: String, data: Data, method: Moya.Method, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        requestData(target: .uploadImageAPI(params: params, pageUrl: pageUrl, data: data, method: method), completion: completion)
    }
    
}

class RePinJieURL {
    static  func appendQueryParameters(urlString: String, parameters: [String: String]) -> String? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        return urlComponents.url?.absoluteString
    }
}
