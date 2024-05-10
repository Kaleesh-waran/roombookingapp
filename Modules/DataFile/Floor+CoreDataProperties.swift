//
//  Floor+CoreDataProperties.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 22/04/23.
//
//

import Foundation
import CoreData

extension Floor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Floor> {
        return NSFetchRequest<Floor>(entityName: "Floor")
    }

    @NSManaged public var floorNumber: Int16
    @NSManaged public var title: String?
    @NSManaged public var rooms: NSSet?

}

// MARK: Generated accessors for rooms
extension Floor {

    @objc(addRoomsObject:)
    @NSManaged public func addToRooms(_ value: Room)

    @objc(removeRoomsObject:)
    @NSManaged public func removeFromRooms(_ value: Room)

    @objc(addRooms:)
    @NSManaged public func addToRooms(_ values: NSSet)

    @objc(removeRooms:)
    @NSManaged public func removeFromRooms(_ values: NSSet)

}

extension Floor : Identifiable {

}
