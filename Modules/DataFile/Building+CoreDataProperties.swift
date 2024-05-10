//
//  Building+CoreDataProperties.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 22/04/23.
//
//

import Foundation
import CoreData


extension Building {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Building> {
        
        return NSFetchRequest<Building>(entityName: "Building")
    }

    @NSManaged public var buildingName: String?
    @NSManaged public var floors: NSSet?

}

// MARK: Generated accessors for floors
extension Building {

    @objc(addFloorsObject:)
    @NSManaged public func addToFloors(_ value: Floor)

    @objc(removeFloorsObject:)
    @NSManaged public func removeFromFloors(_ value: Floor)

    @objc(addFloors:)
    @NSManaged public func addToFloors(_ values: NSSet)

    @objc(removeFloors:)
    @NSManaged public func removeFromFloors(_ values: NSSet)

}

extension Building : Identifiable {

}
