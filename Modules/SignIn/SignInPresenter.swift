//
//  SignInPresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 11/04/23.
//  
//

import Foundation

protocol PresenterToViewSignInProtocol {
   
    //MARK: Event sends to the view to present the Alertcontroller
    func toShowTheAlertController()
}

protocol PresenterToInteractorSignInProtocol {
    
    var presenter: InteractorToPresenterSignInProtocol? { get set }
    
    //MARK: Send request to the interactor to process the userdetails
    func logicForLogin(username : String,password : String)
    
}

protocol PresenterToRouterSignInProtocol {
    
    //MARK: send events to the router to navigate to the next controller
    func moveToNextController()
    
    //MARK: send events to the router to navigate to the signUp controller
    func navigateToSignUp(from view :PresenterToViewSignInProtocol)
}

class SignInPresenter: ViewToPresenterSignInProtocol
{
    // MARK: Properties
    var view: PresenterToViewSignInProtocol?
    var interactor: PresenterToInteractorSignInProtocol?
    var router: PresenterToRouterSignInProtocol?
    
    //MARK: recieve the events from view and send request to the interactor for signIn validation
    func signInButtonTapped(username: String, password: String) {
        interactor?.logicForLogin(username: username, password: password)
    }
    
    //MARK: send events to the router to navigate to the next page
    func toCheckTheUserSignIn() {
        router?.moveToNextController()
    }
    
    //MARK: send events to the router to prsent the signUp page
    func signUpButtonTapped() {
        guard let view = view else {return}
        router?.navigateToSignUp(from: view)
    }
}

extension SignInPresenter: InteractorToPresenterSignInProtocol {
    
    
    func updateSignInResult(_ result: Bool) {
        if result{
            router?.moveToNextController()
        }
    }
    func toShowTheAlertBox() {
        view?.toShowTheAlertController()
    }
    
}
