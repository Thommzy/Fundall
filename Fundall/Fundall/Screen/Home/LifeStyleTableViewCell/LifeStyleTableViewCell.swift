//
//  LifeStyleTableViewCell.swift
//  Fundall
//
//  Created by Tim on 10/05/2021.
//

import UIKit

class LifeStyleTableViewCell: UITableViewCell {
    
    let identifier = String(describing: LifeStyleTableViewCell.self)
    
    @IBOutlet weak var lifeStyleStackView: UIStackView!
    @IBOutlet weak var tickedImg: UIImageView!
    
    var isTicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tickedImg.isHidden = true
        
        setupLifeStyleStackView()
    }
    
    func setupLifeStyleStackView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(lifeStyleStackViewTapped))
        lifeStyleStackView.isUserInteractionEnabled = true
        lifeStyleStackView.addGestureRecognizer(tap)
    }
    
    @objc func lifeStyleStackViewTapped() {
        isTicked = !isTicked
        if isTicked {
            tickedImg.isHidden = false
        } else {
            tickedImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
