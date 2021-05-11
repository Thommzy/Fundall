//
//  UILabel+Extension.swift
//  Fundall
//
//  Created by Tim on 09/05/2021.
//

import UIKit

extension UILabel {
    func setAttrTextLbl(firstText : String,SecondText :String, firstTextFontSize: CGFloat, secondTextFontSize: CGFloat) {
        let firstTextAttr = NSMutableAttributedString.init(string: firstText, attributes: [NSAttributedString.Key.font : UIFont(name: "FoundersGrotesk-Medium", size: firstTextFontSize)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        let secondTextAttr = NSMutableAttributedString.init(string: SecondText, attributes: [NSAttributedString.Key.font : UIFont(name: "FoundersGroteskRegular", size: secondTextFontSize)!, NSAttributedString.Key.foregroundColor : UIColor.white])
        let combination = NSMutableAttributedString()
        combination.append(firstTextAttr)
        combination.append(secondTextAttr)
        self.attributedText = combination
    }
}
