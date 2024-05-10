//
//  DirectRoomBookingInteractor.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 21/04/23.
//  
//

import Foundation

protocol InteractorToPresenterDirectRoomBookingProtocol {
    
}

class DirectRoomBookingInteractor: PresenterToInteractorDirectRoomBookingProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterDirectRoomBookingProtocol?
    
    var dataManager: CoreDataManager = CoreDataManager.shared
    
    func bookCurrentRoom(buildingName: String,floorNumber: Int,roomNumber: Int,duration: Int){
         
        dataManager.bookRoom(buildingName: buildingName, floorNumber: floorNumber, roomNumber: roomNumber, duration: duration)
    }
}
