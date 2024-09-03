//
//  LPRequsetManager.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import UIKit
import Moya
import SwiftyJSON

enum APIService {
    case getcode(vaguely: String, quizzical: String)
    case getlogin(ordered: String, page: String, patchy: String)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getcode:
            return "/ace/before/harder/tournament"
        case .getlogin:
            return "/lpinoy/while/pages/nabeyaki-udon"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .getcode(let vaguely, let quizzical):
            return .requestParameters(
                parameters: ["vaguely": vaguely, "quizzical": quizzical],
                encoding: JSONEncoding.default
            )
        case .getlogin(let ordered, let page, let patchy):
            return .requestParameters(
                parameters: ["ordered": ordered, "page": page, "patchy": patchy],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Connection": "keep-alive"
        ]
    }
}

class LPRequestManager {
    private let provider = MoyaProvider<APIService>()
    
    private func requestData(
        target: APIService,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
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
    
    private func handleResponse(
        baseModel: BaseModel,
        completion: @escaping (Result<BaseModel, Error>) -> Void
    ) {
        if baseModel.hitch == 0 || baseModel.hitch == 00 {
            completion(.success(baseModel))
        }else if baseModel.hitch == -2 {
            
        }else {
            
        }
    }
    
    func getCode(vaguely: String, quizzical: String, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        requestData(target: .getcode(vaguely: vaguely, quizzical: quizzical), completion: completion)
    }
    
    func login(ordered: String, page: String, patchy: String, completion: @escaping (Result<BaseModel, Error>) -> Void) {
        requestData(target: .getlogin(ordered: ordered, page: page, patchy: patchy), completion: completion)
    }
}

