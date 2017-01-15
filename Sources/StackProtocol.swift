//
//  Stack.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//

import CoreData

public protocol StackProtocol {
    var context: NSManagedObjectContext { get }
    func save()
}
