//
//  HomeViewController.swift
//  Fundall
//
//  Created by Tim on 09/05/2021.
//

import UIKit
import SwiftyUserDefaults
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var eWallertTopCardView: UIView!
    @IBOutlet weak var requestCardParentView: UIView!
    @IBOutlet weak var analyticsParentView: UIView!
    @IBOutlet weak var trackTableView: UITableView!
    @IBOutlet weak var tbvConst: NSLayoutConstraint!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var spentAmountLbl: UILabel!
    @IBOutlet weak var incomeAmountLbl: UILabel!
    
    
    let disposeBag = DisposeBag()
    let profileViewModel = ProfileViewModel(profileDataService: ProfilrDataService())
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEWallertTopCardView()
        setupRequestCardParentView()
        setupAnalyticsParentView()
        setupTrackTableView()
        setupLogoutView()
        
        setupProfileResponse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableviewOberver()
        
        setupProfileResponse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTableviewObserver()
    }
    
    func setupLogoutView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(logoutViewTapped))
        logoutView.isUserInteractionEnabled = true
        logoutView.addGestureRecognizer(tap)
    }
    
    @objc func logoutViewTapped() {
        let controller = LogInViewController.instantiate(storyboardName: "LogIn")
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
        Defaults[\.token] = ""
    }
    
    func setupTrackTableView() {
        trackTableView.register(UINib(nibName: TrackTableViewCell().identifier, bundle: nil), forCellReuseIdentifier: TrackTableViewCell().identifier)
        trackTableView.tableFooterView = UIView.init(frame: CGRect.zero)
        trackTableView.estimatedRowHeight = 110
        trackTableView.rowHeight = UITableView.automaticDimension
        trackTableView.estimatedSectionHeaderHeight = 110
        trackTableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    func setupAnalyticsParentView() {
        analyticsParentView.layer.cornerRadius = 60/2
        analyticsParentView.layer.masksToBounds = true
    }
    
    func setupRequestCardParentView() {
        requestCardParentView.layer.cornerRadius = 60/2
        requestCardParentView.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(requestCardParentViewTapped))
        requestCardParentView.isUserInteractionEnabled = true
        requestCardParentView.addGestureRecognizer(tap)
    }
    
    @objc func requestCardParentViewTapped() {
        let controller = PickCardViewController.instantiate(storyboardName: "Home")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    func setupEWallertTopCardView() {
        eWallertTopCardView.clipsToBounds = true
        eWallertTopCardView.layer.cornerRadius = 15
        eWallertTopCardView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TrackTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell().identifier, for: indexPath) as? TrackTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(TrackTableViewCell().identifier, owner: self, options: nil)?.first as? TrackTableViewCell
        }
        //cell?.sentInvitationDetails = globalSentInvitations[indexPath.row]
        //cell?.delegate = self
        cell?.selectionStyle = .none
        cell?.preservesSuperviewLayoutMargins = false
        //cell?.separatorInset = UIEdgeInsets.zero
        //cell?.layoutMargins = UIEdgeInsets.zero
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action1 = UITableViewRowAction(style: .default, title: "Edit Budget", handler: {
            (action, indexPath) in
            print("Action1")
        })
        action1.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.9098039216, blue: 0.5843137255, alpha: 1)
        let action2 = UITableViewRowAction(style: .default, title: "View Transaction", handler: {
            (action, indexPath) in
            print("Action2")
        })
        action2.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.537254902, blue: 0.5019607843, alpha: 1)
        return [action1, action2]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}



//MARK: - Tableview Observer
extension HomeViewController {
    
    private func addTableviewOberver() {
        self.trackTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    
    private func removeTableviewObserver() {
        if self.trackTableView.observationInfo != nil {
            self.trackTableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.trackTableView && keyPath == "contentSize" {
                self.tbvConst.constant = self.trackTableView.contentSize.height
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
    }
}

//MARK:- API CALLS
extension HomeViewController {
    func setupProfileResponse() {
        profileViewModel.profileResult.asObservable()
            .subscribe(onNext: { [unowned self]
                result in
                totalBalanceLbl.text = result?.success?.data?.totalBalance
                incomeAmountLbl.text = result?.success?.data?.income
                spentAmountLbl.text = result?.success?.data?.spent
                print("user>>>", result)
            })
            .disposed(by: disposeBag)
        profileViewModel.getProfile()
    }

}
