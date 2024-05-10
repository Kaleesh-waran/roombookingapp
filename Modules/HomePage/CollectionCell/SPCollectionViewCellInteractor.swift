//
//  SPCollectionViewCellInteractor.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation

protocol InteractorToPresenterSPCollectionViewCellProtocol {
    
}

class SPCollectionViewCellInteractor: PresenterToInteractorSPCollectionViewCellProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterSPCollectionViewCellProtocol?
    
}
