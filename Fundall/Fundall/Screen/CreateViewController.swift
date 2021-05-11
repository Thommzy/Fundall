//
//  CreateViewController.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

class CreateViewController: UIViewController {
    @IBOutlet weak var getStartedLbl: UILabel!
    @IBOutlet weak var subGetStartedLbl: UILabel!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginLbl: UILabel!
    
    let disposeBag = DisposeBag()
    let authViewModel = AuthViewModel(authDataService: AuthDataService())
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openingScreen()
        setupRegisterResponse()
        setupLoginLbl()
        
    }
    
    func openingScreen() {
        if Defaults[\.token] != "" {
            let controller = HomeViewController.instantiate(storyboardName: "Home")
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true)
        }
    }
    
    
    func setupLoginLbl() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginLblTapped))
        loginLbl.isUserInteractionEnabled = true
        loginLbl.addGestureRecognizer(tap)
    }
    
    @objc func loginLblTapped() {
        let controller = WelcomeViewController.instantiate(storyboardName: Storyboard.login)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        let firstName = firstNameTxtField.text ?? String()
        let lastName = lastNameTxtField.text ?? String()
        let email = emailTxtField.text ?? String()
        let password = passwordTxtField.text ?? String()
        let passwordConfirmation = passwordTxtField.text ?? String()
        let data = RegisterModelRequest(firstName: firstName, lastName: lastName, email: email, password: password, passwordConfirmation: passwordConfirmation)
        Defaults[\.userFirstName] = firstName
        Defaults[\.userEmail] = email
        authViewModel.doRegister(data: data)
    }
    
}

//MARK:-Api Response.
extension CreateViewController {
    func setupRegisterResponse() {
        authViewModel.registerResult.asObservable()
            .subscribe(onNext: {
                result in
                if let result = result {
                    if result.success?.status == "SUCCESS" {
                        self.activityIndicator.stopAnimating()
                        let controller = LogInViewController.instantiate(storyboardName: Storyboard.login)
                        controller.modalPresentationStyle = .fullScreen
                        self.present(controller, animated: true)
                        
                    }
                }
            })
            .disposed(by: disposeBag)
        
        authViewModel.error.asObservable()
            .subscribe(onNext: {
                [unowned self] error in
                if error != nil {
                    activityIndicator.stopAnimating()
                    self.toast(to: error!.asAFError?.errorDescription ?? "Error Authenticating")
                }
            })
            .disposed(by: disposeBag)
    }
}
