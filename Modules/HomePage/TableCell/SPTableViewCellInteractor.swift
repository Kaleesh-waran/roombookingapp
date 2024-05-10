//
//  SPTableViewCellInteractor.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 27/04/23.
//  
//

import Foundation

protocol InteractorToPresenterSPTableViewCellProtocol {
 
}

class SPTableViewCellInteractor: PresenterToInteractorSPTableViewCellProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterSPTableViewCellProtocol?

}
