//
//  ListEntity.swift
//  Pods
//
//  Created by Sergei Perevoznikov on 15/01/2017.
//
//

public struct ListEntity: EntityProtocol {
    public var name: String = List.entityName
    public var properties: [Attribute] = []
    
    public init() {
        var idAttribute = Attribute()
        idAttribute.name = List.propertyId
        idAttribute.attributeType = .string
        idAttribute.isOptional = false
        idAttribute.isIndexed = true
        properties.append(idAttribute)
        
        var nameAttribute = Attribute()
        nameAttribute.name = List.propertyName
        nameAttribute.attributeType = .string
        nameAttribute.isOptional = false
        nameAttribute.isIndexed = true
        properties.append(nameAttribute)
    }
}
