//
//  List.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 08/01/2017.
//  Copyright © 2017 Sergei Perevoznikov. All rights reserved.
//

import CoreData
import ShoppingModels

public class List: ListProtocol {
    public static let entityName = "ListEntity"
    public static let propertyId = "id"
    public static let propertyName = "name"
    
    public var id: String
    public var name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(object: NSManagedObject) {
        id = object.value(forKey: List.propertyId) as! String
        name = object.value(forKey: List.propertyName) as! String
    }
}
