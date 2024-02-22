//  Student Name: Pasang Yangji Tamang
//  Student Id: 12210663
//  Class Name: AddPropertyViewController.swift
//  Folder Name: PropertyList
/*
 Purpose of the class:
 This class serves as a user interface for adding new properties to the application, ensuring data validation and communication with the parent view controller via a delegate.
*/

import UIKit

//method for adding a property to the model
protocol AddPropertyDelegate{
    func add(property: Property)
}

class AddPropertyViewController: UIViewController {

    //IBOutlet property to connect with variables
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var typeTextField: UITextField!
    
    let addressPlaceholder = "Enter Address" //defining placeholder for address
    
    var delegate: AddPropertyDelegate? // delegate property to handle adding new properties
    
    // View controller's viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextView.text = addressPlaceholder
        addressTextView.delegate = self
    }
    
    // Action method for cancel button tap event
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // Action method for save button tap event
    @IBAction func didTapSave(_ sender: Any) {
        // Validation for type
        guard let typeText = typeTextField.text, !typeText.isEmpty else {
             showErrorAlert(message: "Please enter property type.")
             return
         }
        let type = typeText.lowercased()
        
        // Validation for price
         guard let priceText = priceTextField.text, !priceText.isEmpty else {
             showErrorAlert(message: "Please enter property price.")
             return
         }
        // validating price if it is numeric or not
        guard Double(priceText) != nil else {
             showErrorAlert(message: "Please enter a valid price.")
             return
         }
         
         // Validation for address
         guard addressTextView.text != addressPlaceholder, !addressTextView.text.isEmpty else {
             showErrorAlert(message: "Please enter property address.")
             return
         }
        
        // Creating a new Property object with the entered data
         let newProperty = Property(address: addressTextView.text, imageName: "PropertyResources/new.jpg", thumbnailName: "PropertyResources/thumbnail_new.jpg", type: PropertyType(rawValue: type) ?? .house, price: priceText)
        
        // Notify the delegate to add the new property to the model and dismiss it
        delegate?.add(property: newProperty)
         dismiss(animated: true)
    }
    
    // Method to show an error alert with a given message
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AddPropertyViewController: UITextViewDelegate{
    
    // Method called when text view begins editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.tertiaryLabel{
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    // Method called when text view ends editing
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = addressPlaceholder
            textView.textColor = UIColor.tertiaryLabel
        }
    }
}
