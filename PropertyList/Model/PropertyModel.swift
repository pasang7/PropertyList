//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: PropertyModel.swift
//  Folder Name: PropertyList
/*
 Purpose of the class:
 This class serves as a model for managing properties in the application. It includes functions to load property data, filter properties based on their type, add new properties to the model and manage a list of watched properties.
*/

import Foundation

// Private properties to store all properties and watched properties
class PropertyModel{
    
    private(set) var properties: [Property] = [] // Array to store all properties
    var watchedProperties: [Property] = [] // Array to store watched properties
    
    init(){
        if let url = Bundle.main.url(forResource: "PropertyResources/properties", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                properties = try JSONDecoder().decode([Property].self, from:data)
                
            } catch {
                print(error)
            }
        }
    }
    
    // Function to filter properties based on their type
    func properties(forType type: PropertyType?) -> [Property] {
        guard let type = type else { return properties }
        // Filter properties array to only include properties of the specified type
        return properties.filter { $0.type == type }
    }
    
    // Function to add a new property to the properties array
    func add(property: Property){
        properties.append(property)
    }
    
    // Function to add a property to the watched properties array
    func addToWatchedProperties(property: Property) {
            watchedProperties.append(property)
    }
}
