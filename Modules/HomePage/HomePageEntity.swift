//
//  HomePageEntity.swift
//  Offiz
//
//  Created by Kaleeshwaran.p on 12/04/23.
//

import Foundation
import CoreData


public struct MyRoom: Equatable {
    
    var roomNumber: Int
}

public struct MyFloor {
    
    var title: String
    var rooms: [MyRoom]
    var floorNumber: Int
}

public struct MyBuilding{
    
    var buildingName : String
    var floors : [MyFloor]
    var bookedRooms: [MyRoom] = []
}

class HomePageEntity {
    
    var buildings: [MyBuilding] = []
    
    static let shared = HomePageEntity()
 
    init() {

        buildings = CoreDataManager.shared.fetchAvailableBuildings()
    }
}

