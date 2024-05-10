//
//  SignUpRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

class SignUpRouter: PresenterToRouterSignUpProtocol {
   
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = SignUpViewController()
        
        let presenter: ViewToPresenterSignUpProtocol & InteractorToPresenterSignUpProtocol = SignUpPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SignUpRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SignUpInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func showTheHomeViewController() {

        let vc = DashBoardTabbarController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
    func showSignInPage(from view: PresenterToViewSignUpProtocol) {
        
        guard let signInView = view as? UIViewController else {return}
        signInView.dismiss(animated: true)
    }
}
