//
//  LoginViewController.swift
//  myFirebaseApp
//
//  Created by Muhammed Essa on 1/22/20.
//  Copyright © 2020 Muhammed Essa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let loginToList = "LoginToList"
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard
            let email = emailText.text,
            let password = passwordText.text,
        email.count > 0,
        password.count > 0
            else{
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Login in falied", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true, completion: nil)
            }else{
                
                Auth.auth().addStateDidChangeListener() {
                    auth ,user in
                    if user != nil {
                        self.performSegue(withIdentifier: self.loginToList, sender: nil)
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        let saveAction =  UIAlertAction( title: "Save", style: .default  ) { _ in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text! ) {
                user , error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.emailText.text!, password: self.passwordText.text! )
                    Auth.auth().addStateDidChangeListener() {
                                     auth ,user in
                                     if user != nil {
                                        
                                         self.performSegue(withIdentifier: self.loginToList, sender: nil)
                                     }
                                 }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel )
        alert.addTextField { textEmail in
             textEmail.placeholder = "Enter your email"
         }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        if Auth.auth().currentUser != nil {
          self.performSegue(withIdentifier: self.loginToList, sender: nil)
        } else {
          // No user is signed in.
          // ...
        }
         
    }
    

}
