//
//  ViewController.swift
//  myFirebaseApp
//
//  Created by Muhammed Essa on 1/22/20.
//  Copyright © 2020 Muhammed Essa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let ref = Database.database().reference(withPath: "people")
    var items :[Person] = []
    var personId = ""
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let personObject = items[indexPath.row]
        cell.textLabel?.text = personObject.name + " " + personObject.lname
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personItems = items[indexPath.row]
            personItems.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        personId = items[indexPath.row].key
        performSegue(withIdentifier: "toEdit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit"{
            let editViewController = segue.destination as! EditViewController
            editViewController.personId = personId
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
         
   
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any )
        })
        ref.observe(.value, with: { snapshot in
            var newPerson: [Person] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let persons = Person(snapshot: snapshot){
                    newPerson.append(persons)
                }
            }
            self.items = newPerson
            self.table.reloadData()
             })
     
    }
    
    
    @IBAction func logOut(_ sender: Any) {
 
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
      //   self.performSegue(withIdentifier: "toLoginPage", sender: nil)
     
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
     
        
    }
    
    
    
    


}

