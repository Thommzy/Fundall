//
//  TrackTableViewCell.swift
//  Fundall
//
//  Created by Tim on 10/05/2021.
//

import UIKit
import SnapKit

class TrackTableViewCell: UITableViewCell {
    
    var identifier = String(describing: TrackTableViewCell.self)
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var parentIndicatorView: UIView!
    
    var amountLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupParentIndicatorView()
        setupIndicatorView()
        setupAmountLabel()
    }
    
    func setupParentIndicatorView() {
        parentIndicatorView.layer.cornerRadius = 20
        parentIndicatorView.layer.masksToBounds = true
    }
    func setupAmountLabel() {
        indicatorView.addSubview(amountLabel)
        amountLabel.text = "$450"
        amountLabel.textColor = .white
        amountLabel.font = UIFont(name: "MessinaSans-Regular", size: 15)
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(indicatorView).offset(15)
            make.top.equalTo(indicatorView)
            make.bottom.equalTo(indicatorView)
            make.right.equalTo(indicatorView)
        }
    }
    
    func setupIndicatorView(){
        indicatorView.backgroundColor = #colorLiteral(red: 0, green: 0.477824688, blue: 0.2832695246, alpha: 1)
        indicatorView.layer.cornerRadius = 20
        indicatorView.layer.masksToBounds = true
        indicatorView.snp.makeConstraints { (make) in
            make.width.equalTo(parentIndicatorView).multipliedBy(0.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
