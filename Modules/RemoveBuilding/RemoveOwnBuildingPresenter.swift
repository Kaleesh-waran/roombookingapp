//
//  RemoveOwnBuildingPresenter.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 19/04/23.
//  
//

import Foundation

protocol PresenterToViewRemoveOwnBuildingProtocol {
   
    func sendTheValueOfNumberOfRowsInPickerView(numberOfRows: Int) -> Int
    
    func sendTheValueOfTitleInPickerView(title: String) -> String
}

protocol PresenterToInteractorRemoveOwnBuildingProtocol {
    
    var presenter: InteractorToPresenterRemoveOwnBuildingProtocol? { get set }
    
    func requestTheNumberOfRowsInPickerView() -> Int
    
    func requestTheTitleForEachRowInPickerView(for row: Int) -> String
}

protocol PresenterToRouterRemoveOwnBuildingProtocol {
    
    func toDismissTheAddMeeingController(from view : PresenterToViewRemoveOwnBuildingProtocol)
    
}

class RemoveOwnBuildingPresenter: ViewToPresenterRemoveOwnBuildingProtocol
    {

    // MARK: Properties
    var view: PresenterToViewRemoveOwnBuildingProtocol?
    var interactor: PresenterToInteractorRemoveOwnBuildingProtocol?
    var router: PresenterToRouterRemoveOwnBuildingProtocol?
    
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
}

extension RemoveOwnBuildingPresenter: InteractorToPresenterRemoveOwnBuildingProtocol {
    
    func sendNumberOfRowsInPickerView(numberOfRows: Int) -> Int {
        
        view?.sendTheValueOfNumberOfRowsInPickerView(numberOfRows: numberOfRows) ?? 0
    }
    
    func sendTitleForEachRowInPickerView(title: String) -> String {
        
        view?.sendTheValueOfTitleInPickerView(title: title) ?? ""
    }
}
