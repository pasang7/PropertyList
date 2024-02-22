//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: PropertiesListViewController.swift
//  Folder Name: PropertyList
/*
 Purpose of the class:
    PropertiesListViewController manages a list of properties displayed in a table view.It also provides the method to handle single and double tap gesture. If the single tap is recognised then it will show the property detail page. And if the double tap is detected, it will add the property to the watch list.
*/

import UIKit

class PropertiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! //IBOutlet property to connect with a table view
    
    var model = PropertyModel() // PropertyModel instance for managing property data
    var selectedType: PropertyType? // Property to store the selected type of property (house, unit, land)
    var singleTapTimer: Timer? // Timer to detect single tap or double tap
    var tappedIndexPath: IndexPath?
   
    // viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Add tap gesture recognizer to the table view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tableView.addGestureRecognizer(tapGesture)
    }
    
    // method to handle tap gesture to show property detail or add to watch list
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let touchPoint = gesture.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if tappedIndexPath == indexPath {
                    // Double tap detected
                    handleDoubleTap()
                    tappedIndexPath = nil
                    singleTapTimer?.invalidate()
                } else {
                    // Single tap detected
                    tappedIndexPath = indexPath
                    singleTapTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleSingleTap), userInfo: nil, repeats: false)
                }
            }
        }
    }
    // method to handle single tap action
    @objc func handleSingleTap() {
        if let indexPath = tappedIndexPath {
            let property = model.properties(forType: selectedType)[indexPath.row]
            showPropertyDetail(property)
            tappedIndexPath = nil
        }
    }
    // method to show property detail page
    func showPropertyDetail(_ property: Property) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "PropertyDetailViewController") as? PropertyDetailViewController {
            detailVC.property = property
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // method to handle double tap action
    func handleDoubleTap() {
        print("Double Tap Detected")
        if let indexPath = tappedIndexPath {
            let property = model.properties(forType: selectedType)[indexPath.row]
            model.addToWatchedProperties(property: property)
            showPopup(message: "Property Added to Watches")
            print("watched properties: ", property)
        }
    }

    // method to show popup message
    func showPopup(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
   
    // Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPropertyDetail" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let property = model.properties[indexPath.row]
                let detailVC = segue.destination as? PropertyDetailViewController
                detailVC?.property = property
            }
        } else if segue.identifier == "addProperty" {
            let navVC = segue.destination as? UINavigationController
            let addVC = navVC?.viewControllers.first as? AddPropertyViewController
            addVC?.delegate = self
        }
    }

    // Action method for segmented control value changed event
    @IBAction func didChangeFilter(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = nil
        case 1:
            selectedType = .house
        case 2:
            selectedType = .unit
        case 3:
            selectedType = .land
        default:
            break
        }
        tableView.reloadData()
    }
}

// Extension for UITableViewDataSource methods
extension PropertiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.properties(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath)
        let property = model.properties(forType: selectedType)[indexPath.row]
        
        // Display title and price of property in cell
        cell.textLabel?.text = property.address
        cell.detailTextLabel?.text = "$" + property.price
        cell.imageView?.image = UIImage(named: property.thumbnailName)

        return cell
    }
}

// Extension for UITableViewDelegate methods
extension PropertiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// Extension for AddPropertyDelegate protocol
extension PropertiesListViewController: AddPropertyDelegate {
    func add(property: Property){
        model.add(property: property)
        tableView.reloadData()
    }
}
