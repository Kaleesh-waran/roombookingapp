//
//  DirectRoomBookingPresenter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 21/04/23.
//  
//

import Foundation

protocol PresenterToViewDirectRoomBookingProtocol {
   
}

protocol PresenterToInteractorDirectRoomBookingProtocol {
    
    var presenter: InteractorToPresenterDirectRoomBookingProtocol? { get set }
    
    func bookCurrentRoom(buildingName: String,floorNumber: Int,roomNumber: Int,duration: Int)
}

protocol PresenterToRouterDirectRoomBookingProtocol {
    
    func dismissThePresentedVC(from view: PresenterToViewDirectRoomBookingProtocol)
}

class DirectRoomBookingPresenter: ViewToPresenterDirectRoomBookingProtocol
{
    
    // MARK: Properties
    var view: PresenterToViewDirectRoomBookingProtocol?
    var interactor: PresenterToInteractorDirectRoomBookingProtocol?
    var router: PresenterToRouterDirectRoomBookingProtocol?
    
    func dismissTheBookingController() {
        
        guard let view = view else {return}
        router?.dismissThePresentedVC(from: view)
    }
    
    func roomBookingDetails(buildingName: String, floorNumber: Int, roomNumber: Int, duration: Int) {
        
        interactor?.bookCurrentRoom(buildingName: buildingName, floorNumber: floorNumber, roomNumber: roomNumber, duration: duration)
    }
}

extension DirectRoomBookingPresenter: InteractorToPresenterDirectRoomBookingProtocol {
    
}
