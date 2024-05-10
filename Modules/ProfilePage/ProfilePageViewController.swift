//
//  ProfilePageViewController.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import UIKit

protocol ViewToPresenterProfilePageProtocol {
    
    var view: PresenterToViewProfilePageProtocol? { get set }
    var interactor: PresenterToInteractorProfilePageProtocol? { get set }
    var router: PresenterToRouterProfilePageProtocol? { get set }
}


class ProfilePageViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setUp()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterProfilePageProtocol?
    
    func setUp(){
        
        let presenter  = ProfilePagePresenter()
        let interactor = ProfilePageInteractor()
        let router     = ProfilePageRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        self.presenter = presenter
    }
}

extension ProfilePageViewController: PresenterToViewProfilePageProtocol{
    // TODO: Implement View Output Methods
}
