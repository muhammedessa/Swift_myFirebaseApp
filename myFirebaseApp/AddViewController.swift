//
//  AddViewController.swift
//  myFirebaseApp
//
//  Created by Muhammed Essa on 1/22/20.
//  Copyright © 2020 Muhammed Essa. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController {

    let ref = Database.database().reference(withPath: "people")
    var items :[Person] = []
    
    @IBOutlet weak var nameTextEdit: UITextField!
    @IBOutlet weak var lastNameTextEdit: UITextField!
    @IBOutlet weak var ageEditText: UITextField!
    
    @IBAction func saveItems(_ sender: Any) {
        let addPerson = Person(name: nameTextEdit.text!, lname: lastNameTextEdit.text!, age: ageEditText.text!)
        let addPersonRef = self.ref.childByAutoId()
        addPersonRef.setValue(addPerson.toAnyObject())
    }
    
     
    
 
}
