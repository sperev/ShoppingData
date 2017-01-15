//
//  EntityProtocol.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 15/01/2017.
//
//

public protocol EntityProtocol {
    var name: String { get }
    var properties: [Attribute] { get }
}
