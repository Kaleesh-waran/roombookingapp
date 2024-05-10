//
//  SPCollectionViewCellPresenter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation

protocol PresenterToViewSPCollectionViewCellProtocol {
   
}

protocol PresenterToInteractorSPCollectionViewCellProtocol {
    
    var presenter: InteractorToPresenterSPCollectionViewCellProtocol? { get set }
}

protocol PresenterToRouterSPCollectionViewCellProtocol {
    
}

class SPCollectionViewCellPresenter: ViewToPresenterSPCollectionViewCellProtocol
    {

    // MARK: Properties
    var view: PresenterToViewSPCollectionViewCellProtocol?
    var interactor: PresenterToInteractorSPCollectionViewCellProtocol?
    var router: PresenterToRouterSPCollectionViewCellProtocol?
}

extension SPCollectionViewCellPresenter: InteractorToPresenterSPCollectionViewCellProtocol {
    
}
