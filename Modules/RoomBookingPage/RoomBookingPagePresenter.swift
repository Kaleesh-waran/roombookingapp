//
//  RoomBookingPagePresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol PresenterToViewRoomBookingPageProtocol {
   
}

protocol PresenterToInteractorRoomBookingPageProtocol {
    
    var presenter: InteractorToPresenterRoomBookingPageProtocol? { get set }
}

protocol PresenterToRouterRoomBookingPageProtocol {
    
    func toDismissTheVC(from view : PresenterToViewRoomBookingPageProtocol)
}

class RoomBookingPagePresenter: ViewToPresenterRoomBookingPageProtocol
{
    
    // MARK: Properties
    var view: PresenterToViewRoomBookingPageProtocol?
    var interactor: PresenterToInteractorRoomBookingPageProtocol?
    var router: PresenterToRouterRoomBookingPageProtocol?
    
    func toDismissTheRoomBookingPageVC() {
        
        guard let dismissView = view else {return}
        router?.toDismissTheVC(from: dismissView)
    }
}

extension RoomBookingPagePresenter: InteractorToPresenterRoomBookingPageProtocol {
    
}
