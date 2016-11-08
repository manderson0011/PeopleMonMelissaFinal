//
//  RegisterViewController.swift
//  ProjectPeoplemon
//
//  Created by Melissa Anderson on 11/5/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SubmitRegistration(_ sender: Any) {
        //validate user input
        guard let username = userNameTextField.text, username != "" else {
            //show earror
            let alert = Utils.createAlert("Login Error", message: "Please provide a user name", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        guard let email = emailTextField.text , email != "" && Utils.isValidEmail(email)
            else{
                let alert = Utils.createAlert("Login Error", message: "Please provide a valid email address", dismissButtonTitle: "Close")
                present(alert, animated: true, completion: nil)
                return
        }
        
        guard let password = passwordTextField.text , password != ""
            else{
                let alert = Utils.createAlert("Login Error", message: "Please provide a password", dismissButtonTitle: "Close")
                present(alert, animated: true, completion: nil)
                return
        }
        guard let confirm = confirmPasswordTextField.text , password == confirm
            
            else {
                present(Utils.createAlert("Login Error", message: "Passwords do not Match"), animated: true, completion: nil)
                return
        }
        
        
        // Going to go ahead with the register
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let user = User(email: email, password: password, changePassword: confirm)
        
        UserStore.shared.register(User) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if success{
                self.dismiss(animated: true, completion: nil)
                
            }else if let error = error{
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
            }else {
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


