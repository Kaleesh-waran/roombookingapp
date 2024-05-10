//
//  SignInInteractor.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 11/04/23.
//  
//

import Foundation

protocol InteractorToPresenterSignInProtocol {
    
    func updateSignInResult(_ result: Bool)
    
    func toShowTheAlertBox()
}

class SignInInteractor: PresenterToInteractorSignInProtocol {
   
    // MARK: Properties
    var presenter: InteractorToPresenterSignInProtocol?
    
    //MARK: - data objects -
    private var signInEntities : [SignInEntity] = [
        SignInEntity(username: "Sonai", password: "sojan")
    ]
    
    func logicForLogin(username: String, password: String) {
        
        if username == signInEntities[0].username && password == signInEntities[0].password {
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            presenter?.updateSignInResult(true)
        }
        else {
            presenter?.toShowTheAlertBox()
        }
    }
}
