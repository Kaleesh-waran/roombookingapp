//
//  SignUpInteractor.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol InteractorToPresenterSignUpProtocol {
    
    func updateSignUpResult(_ result : Bool)
    
    func showTheAlertBox()
    
    func showTheError()
}

class SignUpInteractor: PresenterToInteractorSignUpProtocol {
   
    // MARK: Properties
    var presenter: InteractorToPresenterSignUpProtocol?
    
    // MARK: - Properties -
    private var signUpEntity : [SignUpEntity] = []
    
    func validateTheUserInput(username: String, mailId: String, password: String, confimPassword: String) {
        if ((username != "") && (mailId != "") && (password != "") && (confimPassword != "")){
            if (password == confimPassword){
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                signUpEntity.append(SignUpEntity(newUser: username, mailid: mailId, password: password, confirmPassWord: confimPassword))
                presenter?.updateSignUpResult(true)
            }
            else {
                presenter?.showTheAlertBox()
            }
        }
        else {
            presenter?.showTheError()
        }
    }
}
