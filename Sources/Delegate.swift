//
//  Delegate.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//

public protocol Delegate: class {
    func objectsWillChange()
    func objectsInserted(indexPath: IndexPath)
    func objectsDeleted(indexPath: IndexPath)
    func objectsUpdated(indexPath: IndexPath, newIndexPath: IndexPath?)
    func objectsDidChange(objects: [Any])
}
