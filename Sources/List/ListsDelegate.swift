//
//  ListsDelegate.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//
import ShoppingModels

public protocol ListsDelegate: Delegate {
    func objectsDidChange(objects: [ListProtocol])
}
