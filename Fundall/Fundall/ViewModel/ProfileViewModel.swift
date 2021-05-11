//
//  ProfileViewModel.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    let profileResult: BehaviorRelay<ProfileModelResponse?> = BehaviorRelay(value: nil)
    
    let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var profileDataService: ProfilrDataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(profileDataService: ProfilrDataService) {
        self.profileDataService = profileDataService
    }
    
    // MARK: - Network call
    func getProfile() {
        self.profileDataService?.requestProfile(completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.profileResult.accept(result)
        })
    }
}
