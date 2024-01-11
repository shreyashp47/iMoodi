//
//  LoginViewController.swift
//  iMoodi
//
//  Created by Shreyash Pattewar on 30/12/23.
//


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    let toast = ToastMessageView()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)

           // Check if the user is already logged in
           if UserDefaults.standard.bool(forKey: Constants.isUserLoggedInKey) {
               self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let password = passwordTextfield.text, let  email = emailTextField.text {
           
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              //guard let strongSelf = self else { return }
              // ...
            
                 if let e = error {
                     print(e.localizedDescription)
                     self.toast.showToast(message: e.localizedDescription)
                     //Make a toast to show error
                 } else {
                    UserDefaults.standard.set(true, forKey: Constants.isUserLoggedInKey)
                    UserDefaults.standard.set(email, forKey: Constants.userEmail)
                     
                    UserDefaults.standard.synchronize()
                     self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                 }
                 
                 
             }
         }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

