//
//  Festival.swift
//  Festi Buddy
//
//  Created by Justin Oakes on 8/15/15.
//  Copyright (c) 2015 Oklasoft. All rights reserved.
//

import Foundation
import CoreData

class Festival: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var title: String

}
