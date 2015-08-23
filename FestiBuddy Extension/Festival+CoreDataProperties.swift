//
//  Festival+CoreDataProperties.swift
//  
//
//  Created by Justin Oakes on 8/23/15.
//
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Festival {

    @NSManaged var title: String?
    @NSManaged var date: NSDate?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?

}
