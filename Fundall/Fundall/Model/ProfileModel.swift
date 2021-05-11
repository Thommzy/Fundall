//
//  ProfileModel.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import Foundation

struct ProfileModelResponse: Codable {
    let success: ProfileModelSuccessResponse?
    let error: String?
    let code: String?
}

struct ProfileModelSuccessResponse: Codable {
    let status: String?
    let data: ProfileModelDataResponse?
}

struct ProfileModelDataResponse: Codable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let email: String?
    let totalBalance: String?
    let income: String?
    let spent: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case totalBalance = "total_balance"
        case id, avatar, email, income, spent
    }
}
