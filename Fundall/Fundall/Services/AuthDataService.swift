//
//  AuthDataService.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import Foundation
import Alamofire

struct AuthDataService {
    
    // MARK: - Singleton
    static let shared = AuthDataService()
    
    // MARK: - Services
    func requestRegister(data: RegisterModelRequest, completion: @escaping (RegisterModelResponse?, Error?) -> ()) {
        let url = "\(API.baseURL)/api/\(Version.v1)/register"
        
        let parameters: [String: Any] = [
            "firstname": data.firstName,
            "lastname": data.lastName,
            "email": data.email,
            "password": data.password,
            "password_confirmation": data.passwordConfirmation
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: RegisterModelResponse.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }
    
    func requestLogin(data: LoginModelRequest, completion: @escaping (LoginModelResponse?, Error?) -> ()) {
        let url = "\(API.baseURL)/api/\(Version.v1)/login"
        
        let parameters: [String: Any] = [
            "email": data.email ?? String(),
            "password": data.password ?? String()
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginModelResponse.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }
}
