//
//  UIView+Extensions.swift
//  Fundall
//
//  Created by Tim on 11/05/2021.
//

import UIKit

extension UIView {
    var sceneDelegate: SceneDelegate {
        return  UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
    }
}
