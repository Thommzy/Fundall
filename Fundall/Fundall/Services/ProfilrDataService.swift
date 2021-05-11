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
    
    func requestUploadImage(image: UIImage?, completion: @escaping(ImageModelResponse?, Error?) -> ()) {
        let token = Defaults[\.token]
        let url = "\(API.baseURL)/api/\(Version.v1)/base/avatar"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image!.jpegData(compressionQuality: 0.6)!, withName: "avatar" , fileName: "avatar.jpeg", mimeType: "image/jpeg")
            },
            to: url, method: .post , headers: headers).responseDecodable(of: ImageModelResponse.self) {
                response in
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
