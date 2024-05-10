//
//  RemoveOwnBuildingInteractor.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation

protocol InteractorToPresenterRemoveOwnBuildingProtocol {
    
    func sendNumberOfRowsInPickerView(numberOfRows: Int) -> Int
    
    func sendTitleForEachRowInPickerView(title: String) -> String
}

class RemoveOwnBuildingInteractor: PresenterToInteractorRemoveOwnBuildingProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterRemoveOwnBuildingProtocol?
    
    var model = HomePageEntity.shared
    
    func requestTheNumberOfRowsInPickerView() -> Int {
        
        presenter?.sendNumberOfRowsInPickerView(numberOfRows: model.buildings.count) ?? 0
    }
    
    func requestTheTitleForEachRowInPickerView(for row: Int) -> String {
        
        presenter?.sendTitleForEachRowInPickerView(title: model.buildings[row].buildingName) ?? ""
    }
}
