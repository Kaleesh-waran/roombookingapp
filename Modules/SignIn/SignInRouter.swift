//
//  SignInRouter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 11/04/23.
//  
//

import Foundation
import UIKit

class SignInRouter: PresenterToRouterSignInProtocol {
   
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController : SignInViewController = (storyboard.instantiateViewController(withIdentifier: "myVCID") as? SignInViewController){
            
            
            let presenter: ViewToPresenterSignInProtocol & InteractorToPresenterSignInProtocol = SignInPresenter()
            
            viewController.presenter = presenter
            viewController.presenter?.router = SignInRouter()
            viewController.presenter?.view = viewController
            viewController.presenter?.interactor = SignInInteractor()
            viewController.presenter?.interactor?.presenter = presenter
            
            return viewController
        }
        return UIViewController()
    }
    
    //MARK: function to move to Dashboard controller after signedIn
    func moveToNextController() {
        
        let vc = DashBoardTabbarController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
    //MARK: function to navigate to signUp 
    func navigateToSignUp(from view :PresenterToViewSignInProtocol) {
        
        guard let signInView = view as? UIViewController else {return}
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        signInView.present(signUpVC, animated: true)
    }
}
