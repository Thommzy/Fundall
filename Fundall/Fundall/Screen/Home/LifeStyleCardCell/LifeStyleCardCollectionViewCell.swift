//
//  LifeStyleCardCollectionViewCell.swift
//  Fundall
//
//  Created by Tim on 10/05/2021.
//

import UIKit

class LifeStyleCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lifestyleParentView: UIView!
    
    let identifier = String(describing: LifeStyleCardCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLifestyleParentView()
    }
    
    func setupLifestyleParentView() {
        lifestyleParentView.layer.cornerRadius = 20
        lifestyleParentView.layer.masksToBounds = true
    }

}
