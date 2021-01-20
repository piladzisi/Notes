//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Anna Sibirtseva on 20/01/2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String
    @NSManaged public var category: String?

}

extension Note : Identifiable {

}
