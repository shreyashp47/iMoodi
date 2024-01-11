//
//  CreateUserController.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 11/01/24.
//

import UIKit
import FirebaseAuth

class CreateUserController: UIViewController {
    let toastView = ToastMessageView()
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var verifyPassowrd: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onCreatePressed(_ sender: UIButton) {
        
      
            if password.text == verifyPassowrd.text {
                if let password = password.text, let  email = emailAddress.text {
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if let e = error {
                            print(e.localizedDescription)
                            self.toastView.showToast(message: e.localizedDescription)
                            //Make a toast to show error
                        } else { 
                            UserDefaults.standard.set(true, forKey: Constants.isUserLoggedInKey)
                            UserDefaults.standard.set(email, forKey: Constants.userEmail)
                            UserDefaults.standard.synchronize()
                            self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                        }
                    }
                }
            }
        else {
                
                toastView.showToast(message: "Verify Password")
                
            
        }}
}


