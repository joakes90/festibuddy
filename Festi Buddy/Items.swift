//
//  Items.swift
//  Festi Countdown
//
//  Created by Justin Oakes on 2/1/15.
//  Copyright (c) 2015 Justin Oakes. All rights reserved.
//

import Foundation
import CoreData

class Items: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var have: NSNumber
    
}
