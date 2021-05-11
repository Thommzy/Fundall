//
//  ImageModel.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import Foundation

struct ImageModelResponse: Codable {
    let success: ImageSuccessModelResponse?
    let error: ImageErrorModelResponse?
}

struct ImageSuccessModelResponse: Codable {
    let status: String?
    let url: String?
    let message: String?
}

struct ImageErrorModelResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
}
