//
//  SignupViewController.swift
//  SnapchatClonePt3
//
//  Created by SAMEER SURESH on 3/19/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
        TODO:
        
        Implement sign up functionality using the Firebase Auth create user function.
        If an error occurs, you should display an error message using a UIAlertController (e.g. if the password is less than 6 characters long). 
        Otherwise, using the user object that is returned from the createUser call, make a profile change request and set the user's displayName property to the name variable. 
        After committing the change request, you should perform a segue to the main screen using the identifier "signupToMain"
 
    */
    @IBAction func didAttemptSignup(_ sender: UIButton) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        // YOUR CODE HERE
        if password.characters.count < 6 {
            let alert = UIAlertController(title: "Sign-up Failed", message: "Password must consist of at least 6 characters.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default) { action in
                // perhaps use action.title here
            })
            self.present(alert, animated: true)
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            // [START_EXCLUDE]
            if let error = error {
                // Implement Alert
                return
            }
            print("\(user!.email!) created")
            let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
            changeRequest?.displayName = name
            self.performSegue(withIdentifier: "signupToMain", sender: self)
            // [END_EXCLUDE]
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
