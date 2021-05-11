//
//  PickCardViewController.swift
//  Fundall
//
//  Created by Tim on 10/05/2021.
//

import UIKit
import SwiftyUserDefaults

class PickCardViewController: UIViewController {
    
    @IBOutlet weak var lifestyleCollectionView: UICollectionView!
    @IBOutlet weak var lifeStyleTableView: UITableView!
    @IBOutlet weak var tbvConst: NSLayoutConstraint!
    
    @IBOutlet weak var userImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLifestyleCollectionView()
        setupLifeStyleTableView()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTableviewObserver()
    }
    
    func loadImage() {
        DispatchQueue.main.async {
            let userImage = Defaults[\.profileImage]
            let url = URL(string: userImage)
            self.userImageView.kf.setImage(with: url)
            self.userImageView.layer.cornerRadius = 60/2
            self.userImageView.layer.masksToBounds = true
            self.userImageView.contentMode = .scaleAspectFill
        }
    }
    
    func setupLifeStyleTableView() {
        lifeStyleTableView.register(UINib(nibName: LifeStyleTableViewCell().identifier, bundle: nil), forCellReuseIdentifier: LifeStyleTableViewCell().identifier)
        lifeStyleTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        lifeStyleTableView.estimatedRowHeight = 110
        lifeStyleTableView.rowHeight = UITableView.automaticDimension
        lifeStyleTableView.estimatedSectionHeaderHeight = 110
        lifeStyleTableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    func setupLifestyleCollectionView() {
        lifestyleCollectionView.register(UINib(nibName: LifeStyleCardCollectionViewCell().identifier, bundle: nil), forCellWithReuseIdentifier: LifeStyleCardCollectionViewCell().identifier)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        let alertView = CustomPopUp.init(UIScreen.main.bounds)
        alertView.onEditOrDeleteClick = { (buttonTitle) in
        }
    }
    
}

extension PickCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LifeStyleTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: LifeStyleTableViewCell().identifier, for: indexPath) as? LifeStyleTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(LifeStyleTableViewCell().identifier, owner: self, options: nil)?.first as? LifeStyleTableViewCell
        }
        cell?.selectionStyle = .none
        cell?.preservesSuperviewLayoutMargins = false
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

extension PickCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LifeStyleCardCollectionViewCell().identifier, for: indexPath) as? LifeStyleCardCollectionViewCell
        cell?.layoutIfNeeded()
        return cell!
    }
}



extension PickCardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}



//MARK: - Tableview Observer
extension PickCardViewController {
    
    private func addTableviewOberver() {
        self.lifeStyleTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    private func removeTableviewObserver() {
        if self.lifeStyleTableView.observationInfo != nil {
            self.lifeStyleTableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.lifeStyleTableView && keyPath == "contentSize" {
                self.tbvConst.constant = self.lifeStyleTableView.contentSize.height
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
    }
}
