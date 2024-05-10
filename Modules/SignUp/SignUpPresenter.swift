//
//  SignUpPresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewSignUpProtocol {
   
    func showTheAlertController()
    
    func showTheErrorBox()
}

protocol PresenterToInteractorSignUpProtocol {
    
    var presenter: InteractorToPresenterSignUpProtocol? { get set }
    
    func validateTheUserInput(username: String, mailId: String, password: String, confimPassword: String)
    
   
}

protocol PresenterToRouterSignUpProtocol {
    
    func showTheHomeViewController()
    
    func showSignInPage(from view :PresenterToViewSignUpProtocol)
}

class SignUpPresenter: ViewToPresenterSignUpProtocol
{
   
    func signUpButtonTapped(username: String, mailId: String, password: String, confimPassword: String) {
        interactor?.validateTheUserInput(username: username, mailId: mailId, password: password, confimPassword: confimPassword)
    }
    
    // MARK: Properties
    var view: PresenterToViewSignUpProtocol?
    var interactor: PresenterToInteractorSignUpProtocol?
    var router: PresenterToRouterSignUpProtocol?
    
    func dismissTheSignUpVC() {
        guard let view = view else {return}
        router?.showSignInPage(from: view)
    }
}

extension SignUpPresenter: InteractorToPresenterSignUpProtocol {
    
    func showTheError() {
        view?.showTheErrorBox()
    }
    
    func updateSignUpResult(_ result: Bool) {
        router?.showTheHomeViewController()
    }
    
    func showTheAlertBox() {
        view?.showTheAlertController()
    }
}
