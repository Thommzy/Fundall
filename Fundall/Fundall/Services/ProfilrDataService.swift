//
//  ProfilrDataService.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

struct ProfilrDataService {
    
    // MARK: - Singleton
    static let shared = ProfilrDataService()
    
    // MARK: - Services
    func requestProfile(completion: @escaping (ProfileModelResponse?, Error?) -> ()) {
        let token = Defaults[\.token]
        let url = "\(API.baseURL)/api/\(Version.v1)/base/profile"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: ProfileModelResponse.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let user = response.value {
                completion(user, nil)
                return
            }
        }
    }
}
