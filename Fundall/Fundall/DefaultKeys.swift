//
//  DefaultKeys.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//
import SwiftyUserDefaults

extension DefaultsKeys {
    var errorMessage: DefaultsKey<String> { return .init("errorMessage", defaultValue: "") }
    var userEmail: DefaultsKey<String> { return .init("userEmail", defaultValue: "") }
    var userFirstName: DefaultsKey<String> { return .init("userFirstName", defaultValue: "") }
    var token: DefaultsKey<String> { return .init("token", defaultValue: "") }
    var profileImage: DefaultsKey<String> { return .init("profileImage", defaultValue: "") }
}
