//
//  AuthViewModel.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

class AuthViewModel {
    
    let registerResult: BehaviorRelay<RegisterModelResponse?> = BehaviorRelay(value: nil)
    
    let loginResult: BehaviorRelay<LoginModelResponse?> = BehaviorRelay(value: nil)
    
    let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var authDataService: AuthDataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var updateLoadingStatus: (() -> ())?
    
    // MARK: - Constructor
    init(authDataService: AuthDataService) {
        self.authDataService = authDataService
    }
    
    // MARK: - Network call
    func doRegister(data: RegisterModelRequest) {
        self.authDataService?.requestRegister(data: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.registerResult.accept(result)
        })
    }
    
    
    func doLogin(data: LoginModelRequest) {
        self.authDataService?.requestLogin(data: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.loginResult.accept(result)
        })
    }
    
   
    
}
