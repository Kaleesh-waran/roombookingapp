//
//  AddMeetingTabBarViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterAddMeetingTabBarProtocol {
    
    var view: PresenterToViewAddMeetingTabBarProtocol? { get set }
    var interactor: PresenterToInteractorAddMeetingTabBarProtocol? { get set }
    var router: PresenterToRouterAddMeetingTabBarProtocol? { get set }
}


class AddMeetingTabBarViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        setUp()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterAddMeetingTabBarProtocol?
    
    func setUp(){
        
        let presenter : AddMeetingTabBarPresenter = AddMeetingTabBarPresenter()
        let interactor : AddMeetingTabBarInteractor = AddMeetingTabBarInteractor()
        let router  : AddMeetingTabBarRouter = AddMeetingTabBarRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
}

extension AddMeetingTabBarViewController: PresenterToViewAddMeetingTabBarProtocol{
    // TODO: Implement View Output Methods
}
