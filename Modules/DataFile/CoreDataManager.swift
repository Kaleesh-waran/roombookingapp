//
//  MyData.swift
//  CoreDataHome
//
//  Created by Kaleeshwaran.p on 17/04/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RoomBookingApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loadAllBuildings() {
        
        let context = persistentContainer.viewContext
        
        let defaultBuildingsArray: [String] = ["Tower", "New woodlands", "old woodlands", "lakeview", "North Plaza", "South Plaza", "Ocean Building"]
        let defaultFloorArray: [Int] = [13, 4, 1, 3, 5, 6, 2]
        let defaultRoomArray: [Int] = [6, 5, 4, 3, 8, 2, 7]
        
        for (index, buildingName) in defaultBuildingsArray.enumerated() {
            
            let fetchRequest: NSFetchRequest<Building> = Building.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "buildingName == %@", buildingName)
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.isEmpty {
                    
                    let numberOfFloors = defaultFloorArray[index]
                    var floors = [Floor]()

                    for floorNumber in 1...numberOfFloors {
                        
                        let numberOfRooms = defaultRoomArray[index]
                        var rooms = [Room]()

                        for roomNumber in 1...numberOfRooms {
                            
                            let room = Room(context: context)
                            room.roomNumber = Int16(roomNumber)
                            room.isBooked = false
                            room.availableDuration = 0
                            rooms.append(room)
                        }

                        let floor = Floor(context: context)
                        floor.rooms = NSSet(array: rooms) as! Set<Room> as NSSet
                        floor.floorNumber = Int16(floorNumber)
                        floors.append(floor)
                    }

                    let building = Building(context: context)
                    building.buildingName = buildingName
                    building.floors = NSSet(array: floors) as! Set<Floor> as NSSet
                }
            }
            
            catch {
                print("Error in loadAllBuildings function in coredata : \(error)")
            }
            
        }
        do {
            try context.save()
        }
        catch {
            print("Error in loadAllBuildings function in coredata \(error)")
        }
    }
    
    func fetchTheData() -> [Building] {
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Building> = Building.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "buildingName", ascending: true)]
        
        var buildings = [Building]()
        
        do {
            buildings = try context.fetch(fetchRequest)
        }
        
        catch {
            print("Error in fetching the data from core data: \(error)")
        }
        return buildings
    }
    
    func fetchAvailableBuildings() -> [MyBuilding] {

        let buildings = CoreDataManager.shared.fetchTheData()

        var availableBuildings = [MyBuilding]()

        for building in buildings {

            var currentBuilding = MyBuilding(buildingName: building.buildingName ?? "", floors: [])
            var currentFloors: [MyFloor] = []

            if let floors = building.floors?.allObjects.sorted(by: { ($0 as AnyObject).floorNumber < ($1 as AnyObject).floorNumber }) as? [Floor] {

                for (index, floor) in floors.enumerated() {

                    var currentfloor = MyFloor(title: "", rooms: [], floorNumber: index)
                    var currentRooms: [MyRoom] = []
                    
                    if let rooms = floor.rooms?.allObjects.sorted(by: { ($0 as AnyObject).roomNumber < ($1 as AnyObject).roomNumber }) as? [Room] {

                        for (index, _) in rooms.enumerated() {

                                currentRooms.append(MyRoom(roomNumber: index))
                            
                        }
                            
                    }
                    currentfloor.rooms = currentRooms
                    currentFloors.append(currentfloor)
                }
            }
            currentBuilding.floors = currentFloors
            availableBuildings.append(currentBuilding)
        }
        return availableBuildings
    }
    
    
    func addBuilding(buildingName: String, numberOfFloors: Int, numberOfRooms: Int) {
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Building> = Building.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "buildingName == %@", buildingName)
        
        do {
            
            let results = try context.fetch(fetchRequest)
            if let building = results.first {
                
                if let floors = building.floors?.allObjects as? [Floor] {
                    
                    let existingFloorCount = floors.count
                    if numberOfFloors > existingFloorCount {
                    
                        for floorNumber in existingFloorCount + 1...numberOfFloors {
                            
                            let newFloor = Floor(context: context)
                            newFloor.floorNumber = Int16(floorNumber)
                            newFloor.title = ""
                            for roomNumber in 1...numberOfRooms {
                                
                                let newRoom = Room(context: context)
                                newRoom.roomNumber = Int16(roomNumber)
                                newRoom.availableDuration = 0
                                newRoom.isBooked = false
                                newFloor.addToRooms(newRoom)
                            }
                            building.addToFloors(newFloor)
                        }
                    }
                    else if numberOfFloors < existingFloorCount {
                        
                        for floor in floors where floor.floorNumber > Int16(numberOfFloors) {
                            
                            context.delete(floor)
                        }
                    }
                    
                    for floor in floors where floor.floorNumber <= Int16(numberOfFloors) {
                        
                        let rooms = floor.rooms?.allObjects as? [Room]
                        let existingRoomCount = rooms?.count ?? 0
                        if numberOfRooms > existingRoomCount {
                            
                            for roomNumber in existingRoomCount + 1...numberOfRooms {
                                
                                let newRoom = Room(context: context)
                                newRoom.roomNumber = Int16(roomNumber)
                                newRoom.availableDuration = 0
                                newRoom.isBooked = false
                                floor.addToRooms(newRoom)
                            }
                        }
                        else if numberOfRooms < existingRoomCount {
                            
                            if let rooms = floor.rooms?.allObjects as? [Room] {
                                
                                for room in rooms where room.roomNumber > Int16(numberOfRooms) {
                                    
                                    context.delete(room)
                                }
                            }
                        }
                    }
                }
            }
            else {
                
                let newBuilding = Building(context: context)
                newBuilding.buildingName = buildingName
                
                for floorNumber in 1...numberOfFloors {
                    
                    let newFloor = Floor(context: context)
                    newFloor.floorNumber = Int16(floorNumber)
                    newFloor.title = ""
                    
                    for roomNumber in 1...numberOfRooms {
                        
                        let newRoom = Room(context: context)
                        newRoom.roomNumber = Int16(roomNumber)
                        newRoom.availableDuration = 0
                        newRoom.isBooked = false
                        newFloor.addToRooms(newRoom)
                    }
                    newBuilding.addToFloors(newFloor)
                }
            }
            try context.save()
        } catch {
            print("Error in addBuilding function in Core Data: \(error)")
        }
    }

    func removeDataFromCoreData(buildingName: String, floorNumber: Int? = nil, roomNumber: Int? = nil) {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Building> = Building.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "buildingName == %@", buildingName)
         
        do{
            let results = try context.fetch(fetchRequest)
            
            guard let building = results.first else {
                return
            }
            
            if let floorNumber = floorNumber {
                let floors = building.floors?.allObjects as? [Floor]
                let matchingFloors = floors?.filter { $0.floorNumber == Int16(floorNumber) }
                
                for floor in matchingFloors ?? [] {
                    
                    if let roomNumber = roomNumber {
                        
                        let rooms = floor.rooms?.allObjects as? [Room]
                        let matchingRooms = rooms?.filter { $0.roomNumber == Int16(roomNumber) }
                        
                        for room in matchingRooms ?? [] {
                            context.delete(room)
                        }
                    } else {
                        
                        context.delete(floor)
                    }
                }
            } else {
                
                context.delete(building)
            }
            
            do{
                try context.save()
            } catch {
                print("\(error.localizedDescription)")
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func bookRoom(buildingName: String, floorNumber: Int, roomNumber: Int, duration: Int) {
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Building> = Building.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "buildingName == %@", buildingName)
        
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let building = results.first {
                
                if let floors = building.floors?.allObjects.sorted(by: {($0 as AnyObject).floorNumber < ($1 as AnyObject).floorNumber }) as? [Floor] {
                    if let floor = floors.first(where: { $0.floorNumber == Int16(floorNumber + 1) }),
                       let rooms = floor.rooms?.allObjects.sorted(by: { ($0 as AnyObject).roomNumber < ($1 as AnyObject).roomNumber }) as? [Room],
                       let room = rooms.first(where: { $0.roomNumber == Int16(roomNumber) + 1}) {
                        
                        room.isBooked = true
                        room.availableDuration = Double(Int16(duration))
                        try context.save()
                    }
                }
            }
        } catch {
            print("Error in bookRoom function in coredata: \(error)")
        }
    }
    
    func fetchBookedRooms() -> ([String],[Int],[Int],[Int]) {
        
        let buildings = CoreDataManager.shared.fetchTheData()
        var bookedRoomNumbers = [Int]()
        var bookedRoomBuildings = [String]()
        var bookedRoomFloor = [Int]()
        var duration = [Int]()
        
        for building in buildings {
            
            if let floors = building.floors?.allObjects as? [Floor] {
                
                for floor in floors {
                    
                    if let rooms = floor.rooms?.allObjects as? [Room] {
                        
                        for room in rooms where room.isBooked == true {
                            
                            bookedRoomBuildings.append(building.buildingName ?? "")
                            bookedRoomFloor.append(Int(floor.floorNumber))
                            bookedRoomNumbers.append(Int(room.roomNumber))
                            duration.append(Int(room.availableDuration))
                        }
                    }
                }
            }
        }
        return (bookedRoomBuildings,bookedRoomFloor,bookedRoomNumbers,duration)
    }
}

