//
//  Stack.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//

import CoreData

public class Stack: StackProtocol {
    public let context: NSManagedObjectContext
    public init(entities: [EntityProtocol]) {
        let model = NSManagedObjectModel()
        var descriptions: [NSEntityDescription] = []
        for entity in entities {
            let description = NSEntityDescription()
            description.name = entity.name
            var attributes: [NSAttributeDescription] = []
            for property in entity.properties {
                let attribute = NSAttributeDescription()
                if let name = property.name {
                    attribute.name = name
                }
                if let type = property.attributeType, type == .string {
                    attribute.attributeType = .stringAttributeType
                }
                attribute.isIndexed = property.isIndexed
                attribute.isOptional = property.isOptional
                attributes.append(attribute)
            }
            description.properties = attributes
            descriptions.append(description)
        }
        model.entities = descriptions
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        _ = try? coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
    }
    
    public func save() {
        try? context.save()
    }
}
