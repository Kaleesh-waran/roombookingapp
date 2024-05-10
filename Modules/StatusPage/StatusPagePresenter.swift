//
//  StatusPagePresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewStatusPageProtocol {
   
}

protocol PresenterToInteractorStatusPageProtocol {
    
    var presenter: InteractorToPresenterStatusPageProtocol? { get set }
}

protocol PresenterToRouterStatusPageProtocol {
    
}

class StatusPagePresenter: ViewToPresenterStatusPageProtocol
    {

    // MARK: Properties
    var view: PresenterToViewStatusPageProtocol?
    var interactor: PresenterToInteractorStatusPageProtocol?
    var router: PresenterToRouterStatusPageProtocol?
}

extension StatusPagePresenter: InteractorToPresenterStatusPageProtocol {
    
}
