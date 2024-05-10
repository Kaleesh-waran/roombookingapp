//
//  StatusPageInteractor.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol InteractorToPresenterStatusPageProtocol {
    
    
}

class StatusPageInteractor: PresenterToInteractorStatusPageProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterStatusPageProtocol?
    
    let bookedValuesResult = CoreDataManager.shared.fetchBookedRooms()

}

