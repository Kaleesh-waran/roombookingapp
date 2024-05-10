//
//  AddOwnBuildingPresenter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation

protocol PresenterToViewAddOwnBuildingProtocol {
   
    func sendTheValueOfNumberOfRowsInPickerView(numberOfRows: Int) -> Int
    
    func sendTheValueOfTitleInPickerView(title: String) -> String
}

protocol PresenterToInteractorAddOwnBuildingProtocol {
    
    var presenter: InteractorToPresenterAddOwnBuildingProtocol? { get set }
    
    func requestTheNumberOfRowsInPickerView() -> Int
    
    func requestTheTitleForEachRowInPickerView(for row: Int) -> String
    
    func addTheNewBuildingToTheCoreData(buildingName: String, floorNumber: Int, roomNumber: Int)
}

protocol PresenterToRouterAddOwnBuildingProtocol {
    
    func toDismissTheAddMeeingController(from view : PresenterToViewAddOwnBuildingProtocol)
}

class AddOwnBuildingPresenter: ViewToPresenterAddOwnBuildingProtocol
{
    
    // MARK: Properties
    var view: PresenterToViewAddOwnBuildingProtocol?
    var interactor: PresenterToInteractorAddOwnBuildingProtocol?
    var router: PresenterToRouterAddOwnBuildingProtocol?
    
    func toDismissThePresentedController() {
        
        guard let view = view else {return}
        router?.toDismissTheAddMeeingController(from: view)
    }
    
    func getTheNumberOfRowsInPickerView() -> Int {
        
        interactor?.requestTheNumberOfRowsInPickerView() ?? 0
    }
    
    func getTheTitleForEachRowInPickerView(for row: Int) -> String {
        
        interactor?.requestTheTitleForEachRowInPickerView(for: row) ?? ""
    }
    
    func addNewBuildingToTheCoreData(buildingName: String, floorNumber: Int, roomNumber: Int) {
        
        interactor?.addTheNewBuildingToTheCoreData(buildingName: buildingName, floorNumber: floorNumber, roomNumber: roomNumber)
    }
}

extension AddOwnBuildingPresenter: InteractorToPresenterAddOwnBuildingProtocol {
    
    func sendNumberOfRowsInPickerView(numberOfRows: Int) -> Int {
        
        view?.sendTheValueOfNumberOfRowsInPickerView(numberOfRows: numberOfRows) ?? 0
    }
    
    func sendTitleForEachRowInPickerView(title: String) -> String {
        
        view?.sendTheValueOfTitleInPickerView(title: title) ?? ""
    }
}
