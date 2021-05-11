//
//  CustomPopUp.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import UIKit

class CustomPopUp: UIView {
    
    @IBOutlet weak var parentView: UIView!
    var onEditOrDeleteClick:((_ stButton:String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXIB()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(_ frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        loadXIB()
        setupParentView()
        setupRedirect()
    }
    
    func setupRedirect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.removeFromSuperview()
            self.updateConstraints()
            self.layoutIfNeeded()
            let storyboard: UIStoryboard = UIStoryboard (name: "Home", bundle: nil)
            let vc: HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let currentController = self.getCurrentViewController()
            currentController?.modalPresentationStyle = .fullScreen
            currentController?.present(vc, animated: true, completion: nil)
            
            
        }
    }
    
    
    func setupParentView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(parentViewTapped))
        parentView.isUserInteractionEnabled = true
        parentView.addGestureRecognizer(tap)
    }
    
    @objc func parentViewTapped() {
        self.removeFromSuperview()
        self.updateConstraints()
        self.layoutIfNeeded()
    }
    
    func loadXIB() {
        
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        //TOP
        self.addConstraint(NSLayoutConstraint.init(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        
        //LEADING
        self.addConstraint(NSLayoutConstraint.init(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        //WIDTH
        self.addConstraint(NSLayoutConstraint.init(item: view, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        
        //HEIGHT
        self.addConstraint(NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        
        self.layoutIfNeeded()
        
        self.alpha = 0
        
        sceneDelegate.window?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.beginFromCurrentState) {
            self.alpha = 1
        } completion: { (completed) in
            self.layoutIfNeeded()
        }
        
    }
    
    func getCurrentViewController() -> UIViewController? {

        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil

    }
}
