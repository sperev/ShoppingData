//
//  Lists.swift
//  ShoppingModels
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//

import CoreData
import ShoppingModels

public class Lists: NSObject, NSFetchedResultsControllerDelegate, ListsProtocol {
    private let stack: StackProtocol
    private var controller: NSFetchedResultsController<NSManagedObject>
    private weak var delegate: ListsDelegate?
    
    public init(stack: StackProtocol, delegate: ListsDelegate?) {
        self.stack = stack
        self.delegate = delegate
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: List.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: List.propertyName, ascending: true)]
        
        let context = stack.context
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        controller.delegate = self
        try? controller.performFetch()
    }
    
    private func objects(id: String? = nil) -> [NSManagedObject]? {
        let entityName = List.entityName
        let context = stack.context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let id = id {
            fetchRequest.predicate = NSPredicate(format: "\(List.propertyId) LIKE '\(id)'")
        }
        return try? context.fetch(fetchRequest)
    }
    
    public func add(_ model: ListProtocol) {
        let entityName = List.entityName
        let context = stack.context
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                         into: context)
        object.setValue(model.id, forKey: List.propertyId)
        object.setValue(model.name, forKey: List.propertyName)
    }
    
    public func delete(_ model: ListProtocol) {
        let context = stack.context
        objects(id: model.id)?.forEach { object in
            context.delete(object)
        }
    }
    
    public func update(_ model: ListProtocol) {
        objects(id: model.id)?.forEach { object in
            object.setValue(model.name, forKey: List.propertyName)
        }
    }
    
    public func update(models: [ListProtocol]) {
        let context = stack.context
        context.perform { [weak self] in
            let objects: [NSManagedObject]? = self?.objects()
            var updated: [String: Bool] = [:]
            if let objects = objects {
                for object in objects {
                    var exists = false
                    
                    if let id = object.value(forKey: List.propertyId) as? String {
                        for model in models {
                            if model.id == id {
                                exists = true
                                self?.update(model)
                                updated[id] = true
                            }
                        }
                    }
                    
                    if exists == false {
                        context.delete(object)
                    }
                }
            }
            
            for model in models {
                if updated[model.id] == nil {
                    self?.add(model)
                }
            }
            
            self?.save()
        }
    }
    
    public func save() {
        stack.save()
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.objectsWillChange()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        var models: [ListProtocol] = []
        let context = stack.context
        let entityName = List.entityName
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: List.propertyName, ascending: true)]
        if let objects = try? context.fetch(fetchRequest) {
            models = objects.flatMap{ List(object: $0) }
        }
        delegate?.objectsDidChange(objects: models)
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert: delegate?.objectsInserted(indexPath: newIndexPath!)
        case .delete: delegate?.objectsDeleted(indexPath: indexPath!)
        case .move: delegate?.objectsUpdated(indexPath: indexPath!, newIndexPath: newIndexPath)
        case .update: delegate?.objectsUpdated(indexPath: indexPath!, newIndexPath: newIndexPath)
        }
    }
}
