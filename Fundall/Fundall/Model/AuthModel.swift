//
//  AuthModel.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import Foundation

struct RegisterModelRequest: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var passwordConfirmation: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case email, password
        case passwordConfirmation = "password_confirmation"
    }
}

struct RegisterModelResponse: Codable {
    var success: RegisterModelResponseData?
    var error: RegisterModelRequestFailedData?
}

struct RegisterModelResponseData: Codable {
    var message: String
    var status: String
}

struct RegisterModelRequestFailed: Codable {
    var error: RegisterModelRequestFailedData
}

struct RegisterModelRequestFailedData: Codable {
    var message: String
    var status: String
}

struct LoginModelRequest: Codable {
    let email: String?
    let password: String?
}

struct LoginModelResponse: Codable {
    let success: LoginModelSuccessResponse?
    let error: LoginErrorModel?
}

struct LoginModelSuccessResponse: Codable {
    let user : User?
    let status: String?
}

struct User: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let avatar: String?
    let monthlyTarget: Int?
    let createdAt: String?
    let updatedAt: String?
    let accessToken: String?
    let tokenType: String?
    let expiresAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "firstname"
        case lastName = "lastname"
        case monthlyTarget = "monthly_target"
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case id, email, avatar
    }
}

struct LoginModelFailedData: Codable {
    let error: LoginErrorModel?
}

struct LoginErrorModel: Codable {
    let message: String?
    let status: String?
    let code: String?
}
