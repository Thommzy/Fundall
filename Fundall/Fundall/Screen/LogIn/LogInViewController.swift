//
//  LogInViewController.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import UIKit
import SwiftyUserDefaults

class LogInViewController: UIViewController {
    @IBOutlet weak var passwordParentView: UIView!
    @IBOutlet weak var biometricParentView: UIView!
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var switchAccountLbl: UILabel!
    @IBOutlet weak var createAccountLbl: UILabel!
    
    
    let firstName = Defaults[\.userFirstName]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPasswordParentView()
        setupBiometricParentView()
        setupPasswordStackView()
        setupFirstNameLbl()
        setupSwitchAccountLbl()
        setupCreateAccountLbl()
    }
    
    func setupCreateAccountLbl() {
        createAccountLbl.setAttrTextLbl(firstText: "New Here? ", SecondText: " Create Account", firstTextFontSize: 17.0, secondTextFontSize: 17.0)
    }
    
    func setupSwitchAccountLbl() {
        switchAccountLbl.setAttrTextLbl(firstText: "Not \(firstName)? ", SecondText: " Switch Accounts", firstTextFontSize: 17.0, secondTextFontSize: 17.0)
    }
    
    func setupFirstNameLbl() {
        firstNameLbl.setAttrTextLbl(firstText: "\(firstName)'s", SecondText: " Lifestyle", firstTextFontSize: 32.0, secondTextFontSize: 32.0)
    }
    
    func setupPasswordStackView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(passwordStackViewTapped))
        passwordStackView.isUserInteractionEnabled = true
        passwordStackView.addGestureRecognizer(tap)
    }
    
    @objc func passwordStackViewTapped() {
        let storyboard = UIStoryboard(name: Storyboard.login, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func setupPasswordParentView() {
        passwordParentView.layer.borderColor = #colorLiteral(red: 0.2980392157, green: 0.9098039216, blue: 0.5843137255, alpha: 1)
        passwordParentView.layer.borderWidth = 2
        passwordParentView.layer.cornerRadius = 50 / 2
        passwordParentView.layer.masksToBounds = true
    }
    
    func setupBiometricParentView() {
        biometricParentView.layer.borderColor = #colorLiteral(red: 0.2980392157, green: 0.9098039216, blue: 0.5843137255, alpha: 1)
        biometricParentView.layer.borderWidth = 2
        biometricParentView.layer.cornerRadius = 50 / 2
        biometricParentView.layer.masksToBounds = true
    }
}
