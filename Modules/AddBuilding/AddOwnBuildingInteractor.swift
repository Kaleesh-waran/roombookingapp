//
//  AddOwnBuildingInteractor.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation

protocol InteractorToPresenterAddOwnBuildingProtocol {
    
    func sendNumberOfRowsInPickerView(numberOfRows: Int) -> Int
    
    func sendTitleForEachRowInPickerView(title: String) -> String
}

class AddOwnBuildingInteractor: PresenterToInteractorAddOwnBuildingProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterAddOwnBuildingProtocol?
    
    var model = HomePageEntity.shared
    
    func requestTheNumberOfRowsInPickerView() -> Int {
        
        presenter?.sendNumberOfRowsInPickerView(numberOfRows: model.buildings.count) ?? 0
    }
    
    func requestTheTitleForEachRowInPickerView(for row: Int) -> String {
        
        presenter?.sendTitleForEachRowInPickerView(title: model.buildings[row].buildingName) ?? ""
    }
    
    func addTheNewBuildingToTheCoreData(buildingName: String, floorNumber: Int, roomNumber: Int) {
        
        CoreDataManager.shared.addBuilding(buildingName: buildingName, numberOfFloors: floorNumber, numberOfRooms: roomNumber)
        
    }
}
