//
//  SignupViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/1/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField.autocorrectionType = .No
        usernameTextField.autocorrectionType = .No
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        let email = self.emailTextField.text
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        let confirmPassword = self.confirmPasswordTextField.text
        
        let validator = Validator()
        
        if(!(validator.validateEmail(email!))) {
            return
        }else if(!(validator.validateEmail(email!))){
            return
        } else if (!(validator.validateUsername(username!))) {
            return
        } else if (!(validator.validatePassword(password!))){
            return
        } else if (!(validator.validateConfirmPassword(confirmPassword!))) {
            return
        } else if (!(validator.validateArePasswordsEqual(password!, inputConfirmPassword: confirmPassword!))) {
            return
        } else {
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in

                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in                        
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController : HomeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
                        let navigationController = UINavigationController(rootViewController: viewController)
                        self.presentViewController(navigationController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
}
