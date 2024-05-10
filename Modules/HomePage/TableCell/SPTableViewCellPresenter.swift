//
//  SPTableViewCellPresenter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation

protocol PresenterToViewSPTableViewCellProtocol {
 
}

protocol PresenterToInteractorSPTableViewCellProtocol {
    
    var presenter: InteractorToPresenterSPTableViewCellProtocol? { get set }
 
}

protocol PresenterToRouterSPTableViewCellProtocol {
    
}

class SPTableViewCellPresenter: ViewToPresenterSPTableViewCellProtocol
{
    
    // MARK: Properties
    var view: PresenterToViewSPTableViewCellProtocol?
    var interactor: PresenterToInteractorSPTableViewCellProtocol?
    var router: PresenterToRouterSPTableViewCellProtocol?
    
}

extension SPTableViewCellPresenter: InteractorToPresenterSPTableViewCellProtocol {

    
}
