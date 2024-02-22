//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: WatchedPropertiesViewController.swift
//  Folder Name: PropertyList
/*
 Purpose of the class: This class is created to manage the display of a list of properties that have been marked as watched. It includes functionality to connect with a table view and populate it with watched property data.
 */

import UIKit

class WatchedPropertiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! //IBOutlet property to connect with a table view
    
    var model = PropertyModel() // PropertyModel instance for managing property data
       
    // View controller's viewWillAppear method
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("watched listing")
            // Reload the table view data when the watches tab is about to appear
            tableView.reloadData()
    }
}

// Extension for UITableViewDataSource methods
extension WatchedPropertiesViewController: UITableViewDataSource {
    
    // Method to determine the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("kii")
        return model.watchedProperties.count
    }
    
    // Method to configure and return cells for the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCellWatched", for: indexPath)
        let property = model.watchedProperties[indexPath.row]
        
        // Display watched property details in the cell
        cell.textLabel?.text = property.address
        cell.detailTextLabel?.text = "$" + property.price
        cell.imageView?.image = UIImage(named: property.thumbnailName)

        return cell
    }
}
