//
//  HomePageInteractor.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//  
//

import Foundation

protocol InteractorToPresenterHomePageProtocol {
    
    func responseOfTheTextFromInteractor(buildingName: String) //2
    
    func getBuildingsCount(buildingCount: Int) -> Int // 3
    
    func getTheBuildingName(buildingName: String) -> String // 4
    
    func responseOfBuildingNameBasedOnOption(buildingName: String) -> String // 6
    
    func responseOfFloorArrayToPresenter(floorArray: [MyFloor]) -> [MyFloor] // 5
    
    func responseOfSectionCountToPresenter(index: Int) -> Int // 8
    
    func responseOfRoom(room: [MyRoom]) -> [MyRoom] // 9
    
    func responseOfFloor(floor: MyFloor) -> MyFloor // 10
}

class HomePageInteractor: PresenterToInteractorHomePageProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterHomePageProtocol?
    
    var model = HomePageEntity.shared
    
    private var floorsArray : [MyFloor] = []
    
    func requestTheBuildingTitleTextFromInteractor() { // 2
        
        if !model.buildings.isEmpty {
            
            presenter?.responseOfTheTextFromInteractor(buildingName: model.buildings[0].buildingName)
        }
    }
    
    func requestTheNumberOfRowsInPickerView() -> Int { //3
        
        return presenter?.getBuildingsCount(buildingCount: model.buildings.count) ?? 0
    }
    
    func requestTheTitleForEachRowInPickerView(row: Int) -> String { // 4
        
        return presenter?.getTheBuildingName(buildingName: model.buildings[row].buildingName) ?? ""
    }
    
    func requestBuildingLabelBasedOnSelectedIndex(selectedIndex: Int) -> String { // 6
        
        presenter?.responseOfBuildingNameBasedOnOption(buildingName: model.buildings[selectedIndex].buildingName) ?? ""
    }
    
    func selectOption(selectedIndex: Int) { // 5
        
        self.floorsArray = model.buildings[selectedIndex].floors
        _ = presenter?.responseOfFloorArrayToPresenter(floorArray: floorsArray)
    }
    
    func getTheSectionsCount(index: Int) -> Int { // 8
        
        presenter?.responseOfSectionCountToPresenter(index: model.buildings[index].floors.count) ?? 0
    }
    
    func getTheRoomsCount(sectionIndex: Int, index: Int) -> [MyRoom] { //9
        
        return presenter?.responseOfRoom(room: model.buildings[sectionIndex].floors[index].rooms) ?? []
    }
    
    func getTheFloors(selectedIndex: Int, index: Int) -> MyFloor { // 10
        
        return (presenter?.responseOfFloor(floor: model.buildings[selectedIndex].floors[index]))!
    }
}
