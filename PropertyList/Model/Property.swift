//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: Property.swift
//  Folder Name: PropertyList
/*
 Purpose of the class:
 The purpose of the Property is to model real estate properties in an application. It contains address, image, type and price of the properties.
*/


import Foundation

// Define a struct named Property representing property
struct Property: Decodable {
    var address: String
    var imageName: String
    var thumbnailName: String
    var type:PropertyType
    var price: String
    
}

// Define an enum named PropertyType representing the type of property
enum PropertyType: String, Decodable{
    case house = "house"
    case unit = "unit"
    case land = "land"
}
