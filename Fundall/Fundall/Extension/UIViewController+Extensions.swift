//
//  UIViewController+Extensions.swift
//  Fundall
//
//  Created by Tim on 08/05/2021.
//

import UIKit
import Toast_Swift

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate(storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: identifier) as! Self
        return controller
    }
    
    open func toast(to message: String) {
        let style = ToastStyle()
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
}
