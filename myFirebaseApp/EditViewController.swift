//
//  EditViewController.swift
//  myFirebaseApp
//
//  Created by Muhammed Essa on 1/22/20.
//  Copyright © 2020 Muhammed Essa. All rights reserved.
//

import UIKit
import Firebase
class EditViewController: UIViewController {
    let ref = Database.database().reference(withPath: "people")
        var personId = ""
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lnameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(personId)
        // Do any additional setup after loading the view.
        ref.child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
            let personDict = snapshot.value as! [String: Any]
            let name = personDict["name"] as! String
            let lname = personDict["lname"] as! String
            let age = personDict["age"] as! String
            self.nameText.text = name
            self.lnameText.text = lname
            self.ageText.text = age
          print( "name :\(name)  lastName:\(lname)    age: \(age)  "  )
          }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func updatePressed(_ sender: Any) {
        
        let updatePerson = Person(name: nameText.text!, lname: lnameText.text!, age: ageText.text!)
 
        ref.child(personId).updateChildValues(updatePerson.toAnyObject() as! [AnyHashable : Any])
        
        
    }
    

    
 

}
