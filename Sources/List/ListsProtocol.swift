//
//  ListsProtocol.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 14/01/2017.
//
//
import ShoppingModels
public protocol ListsProtocol: class {
    func add(_ model: ListProtocol)
    func delete(_ model: ListProtocol)
    func update(_ model: ListProtocol)
    func save()
}
