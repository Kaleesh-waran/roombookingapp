//
//  HomePagePresenter.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation
import UIKit

protocol PresenterToViewHomePageProtocol {
   
    func sendTheValueToUpdateTheView(buildingText: String) // 2
    
    func sendBuildingCountToPickerView(numberOfRows: Int) -> Int // 3
    
    func sendBuildingNameForRowInPickerView(buildingName: String) -> String // 4
    
    func sendTheBuildingNameBasedOnOption(buildingName: String) -> String
    
    func sendTheFloorArrayToView(floorArray: [MyFloor]) -> [MyFloor] // 5
    
    func sendTheSectionCountToTableView(count: Int) -> Int // 8
     
    func sendTheRoomToTheView(room: [MyRoom]) -> [MyRoom] // 9
    
    func sendTheFloorToTheView(floor: MyFloor) -> MyFloor // 10
}

protocol PresenterToInteractorHomePageProtocol {
    
    var presenter: InteractorToPresenterHomePageProtocol? { get set }
    
    func requestTheBuildingTitleTextFromInteractor()
    
    func requestTheNumberOfRowsInPickerView() -> Int
    
    func requestTheTitleForEachRowInPickerView(row: Int) -> String
    
    func requestBuildingLabelBasedOnSelectedIndex(selectedIndex: Int) -> String // 6
    
    func selectOption(selectedIndex: Int)
    
    func getTheSectionsCount(index: Int) -> Int // 8
    
    func getTheRoomsCount(sectionIndex: Int,index: Int) -> [MyRoom] // 9
    
    func getTheFloors(selectedIndex: Int,index: Int) -> MyFloor // 10
    
}

protocol PresenterToRouterHomePageProtocol {
    
    func switchToLoginVC() // 7
    
    func toPresentProfilePage(from view : PresenterToViewHomePageProtocol) //1
}

class HomePagePresenter: ViewToPresenterHomePageProtocol{
    
    // MARK: Properties
    var view: PresenterToViewHomePageProtocol?
    var interactor: PresenterToInteractorHomePageProtocol?
    var router: PresenterToRouterHomePageProtocol?
    
    func switchToLoginViewController() { // 7
        
        router?.switchToLoginVC()
    }
    
    func presentTheProfileViewController() { //1
        
        guard let profilePageView = view else {return}
        router?.toPresentProfilePage(from: profilePageView)
    }
    
    func toGiveValueToBuildingTitleLabel() { // 2
        
        interactor?.requestTheBuildingTitleTextFromInteractor()
    }
    
    func getTheNumberOfRowsInPickerView() -> Int { //3
        
        interactor?.requestTheNumberOfRowsInPickerView() ?? 0
    }
    
    func getTheTitleForEachRowInPickerView(row: Int) -> String { // 4
        
        interactor?.requestTheTitleForEachRowInPickerView(row: row) ?? ""
    }
    
    func getTheBuildingTextBasedOnOption(selectedIndex: Int) -> String { // 6
        
        interactor?.requestBuildingLabelBasedOnSelectedIndex(selectedIndex: selectedIndex) ?? ""
    }
    
    func selectOption(selectedIndex: Int) { // 5
        
        interactor?.selectOption(selectedIndex: selectedIndex)
    }
    
    func getNumberOfSections(indexPath: Int) -> Int { // 8
        
        interactor?.getTheSectionsCount(index: indexPath) ?? 0
    }
    
    func getTheNumberOfRooms(selectedIndex: Int, index: Int) -> [MyRoom] { // 9
        
        interactor?.getTheRoomsCount(sectionIndex: selectedIndex, index: index) ?? []
    }
    
    func getTheFloor(selectedIndex: Int, index: Int) -> MyFloor { // 10
        
        (interactor?.getTheFloors(selectedIndex: selectedIndex, index: index))!
    }
}

extension HomePagePresenter: InteractorToPresenterHomePageProtocol {
   
    func responseOfTheTextFromInteractor(buildingName: String) { //2
        
        view?.sendTheValueToUpdateTheView(buildingText: buildingName)
    }
    
    func getBuildingsCount(buildingCount: Int) -> Int { // 3
        
        return view?.sendBuildingCountToPickerView(numberOfRows: buildingCount) ?? 0
    }
    
    func getTheBuildingName(buildingName: String) -> String { // 4
        
        view?.sendBuildingNameForRowInPickerView(buildingName: buildingName) ?? ""
    }
    
    func responseOfBuildingNameBasedOnOption(buildingName: String) -> String { // 6
        
        view?.sendTheBuildingNameBasedOnOption(buildingName: buildingName) ?? ""
    }
    
    func responseOfFloorArrayToPresenter(floorArray: [MyFloor]) -> [MyFloor] { //5
        
        view?.sendTheFloorArrayToView(floorArray: floorArray) ?? []
    }
    
    func responseOfSectionCountToPresenter(index: Int) -> Int { // 8
        
        view?.sendTheSectionCountToTableView(count: index) ?? 0
    }
    
    func responseOfRoom(room: [MyRoom]) -> [MyRoom] { // 9
        
        view?.sendTheRoomToTheView(room: room) ?? []
    }
    
    func responseOfFloor(floor: MyFloor) -> MyFloor { // 10
        
        view?.sendTheFloorToTheView(floor: floor) ?? MyFloor(title: "", rooms: [], floorNumber: 0)
    }

}

