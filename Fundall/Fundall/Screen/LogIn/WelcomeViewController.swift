//
//  WelcomeViewController.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import UIKit
import SwiftyUserDefaults
import RxCocoa
import RxSwift

class WelcomeViewController: UIViewController {
    @IBOutlet weak var weMissYouLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var createAccountLbl: UILabel!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    let disposeBag = DisposeBag()
    let authViewModel = AuthViewModel(authDataService: AuthDataService())
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var firstName = Defaults[\.userFirstName]
    var email = Defaults[\.userEmail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWeMissYouLbl()
        setupEmailLbl()
        setupCreateAccountLbl()
        setupLoginResponse()
    }
    
    func setupCreateAccountLbl() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(createAccountLblTapped))
        createAccountLbl.isUserInteractionEnabled = true
        createAccountLbl.addGestureRecognizer(tap)
    }
    
    @objc func createAccountLblTapped() {
        let controller = CreateViewController.instantiate(storyboardName: "Main")
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
        
    }
    
    func setupEmailLbl() {
        emailLbl.text = email
        emailLbl.font = UIFont(name: "FoundersGroteskRegular", size: 17.0)
    }
    
    func setupWeMissYouLbl() {
        weMissYouLbl.text = "We miss you \(firstName)"
        weMissYouLbl.font = UIFont(name: "FoundersGrotesk-Medium", size: 30.0)
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        let email = Defaults[\.userEmail]
        let password = passwordTxtField.text
        let data = LoginModelRequest(email: email, password: password)
        authViewModel.doLogin(data: data)
    }
    
}

//MARK:-Api Response.
extension WelcomeViewController {
    func setupLoginResponse() {
        authViewModel.loginResult.asObservable()
            .subscribe(onNext: {
                result in
                if let result = result {
                    self.activityIndicator.stopAnimating()
                    if result.error != nil {
                        self.toast(to: result.error?.message ?? String())
                    }
                    if result.success != nil {
                        if result.success?.status == "SUCCESS" {
                            Defaults[\.token] = result.success?.user?.accessToken ?? String()
                            let controller = HomeViewController.instantiate(storyboardName: "Home")
                            controller.modalPresentationStyle = .fullScreen
                            self.present(controller, animated: true)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
