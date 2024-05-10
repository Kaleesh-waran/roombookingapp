//
//  HomePageRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class HomePageRouter: PresenterToRouterHomePageProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = HomePageViewController()
        
        let presenter: ViewToPresenterHomePageProtocol & InteractorToPresenterHomePageProtocol = HomePagePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomePageRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomePageInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func switchToLoginVC() { // 7

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "myVCID") as! SignInViewController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC)
    }
    
    func toPresentProfilePage(from view: PresenterToViewHomePageProtocol) { // 1
        
        guard let profileView = view as? UIViewController else {return}
        let profileViewController = ProfilePageViewController()
        profileViewController.modalPresentationStyle = .popover
        profileView.present(profileViewController, animated: true)
    }
}
