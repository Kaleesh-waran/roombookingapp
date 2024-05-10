//
//  Room+CoreDataProperties.swift
//  RoomBookingApp
//
//  Created by Kaleeshwaran.p on 22/04/23.
//
//

import Foundation
import CoreData


extension Room {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Room> {
        return NSFetchRequest<Room>(entityName: "Room")
    }

    @NSManaged public var availableDuration: Double
    @NSManaged public var currentDate: Date?
    @NSManaged public var roomNumber: Int16
    @NSManaged public var isBooked: Bool
}

extension Room : Identifiable {

}
