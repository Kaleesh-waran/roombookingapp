//
//  ProfilePagePresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewProfilePageProtocol {
   
}

protocol PresenterToInteractorProfilePageProtocol {
    
    var presenter: InteractorToPresenterProfilePageProtocol? { get set }
}

protocol PresenterToRouterProfilePageProtocol {
    
}

class ProfilePagePresenter: ViewToPresenterProfilePageProtocol
    {

    // MARK: Properties
    var view: PresenterToViewProfilePageProtocol?
    var interactor: PresenterToInteractorProfilePageProtocol?
    var router: PresenterToRouterProfilePageProtocol?
}

extension ProfilePagePresenter: InteractorToPresenterProfilePageProtocol {
    
}
