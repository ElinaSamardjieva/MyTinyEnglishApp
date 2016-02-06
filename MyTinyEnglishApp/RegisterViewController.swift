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
        
        // Turning off the Autocorrection
        emailTextField.autocorrectionType = .No
        usernameTextField.autocorrectionType = .No
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    //TODO: see again
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
