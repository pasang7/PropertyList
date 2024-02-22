//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: PropertyDetailViewController.swift
//  Folder Name: PropertyList
/*
 Purpose of the class:
 This class responsible for displaying details of a selected property. It contains IBOutlet properties to connect with UI elements in the storyboard. It also provides a property property to hold the selected property for display.
*/

import UIKit

class PropertyDetailViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    
    // Property representing the selected property to display details
    var property: Property!
    
    // View controller's viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UI elements with property details
        bannerImageView.image = UIImage(named: property.imageName)
        priceLabel.text = "$"+property.price
        addressTextView.text = bulletedList(forAddresses: property.address)
    }
    
    // Private method to format addresses into a bulleted list
    private func bulletedList(forAddresses addresses: String) -> String {
        var list = ""
        let items = addresses.split(separator: ",")
        items.forEach { list.append("\($0)\n") }
        return list
    }
}
