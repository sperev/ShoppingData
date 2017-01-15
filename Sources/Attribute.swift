//
//  Attribute.swift
//  ShoppingData
//
//  Created by Sergei Perevoznikov on 15/01/2017.
//
//

enum AttributeType {
    case string
}

public struct Attribute {
    var name: String?
    var attributeType: AttributeType?
    var isOptional: Bool = false
    var isIndexed: Bool = false
}
