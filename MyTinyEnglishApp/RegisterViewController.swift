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
        var email = self.emailTextField.text
        var username = self.usernameTextField.text
        var password = self.passwordTextField.text
        
        let validator = Validator()
        var isValidEmail = validator.isValidEmail(email!)
        
        if(!isValidEmail) {
            var errorMessage = UIAlertView(title: "Try again", message: "The input is invalid email", delegate: self, cancelButtonTitle: "OK")
            errorMessage.show()
            errorMessage.show()
        }else if(email!.isEmpty) {
            var errorMessage = UIAlertView(title: "Try again", message: "Email cannot be empty", delegate: self, cancelButtonTitle: "OK")
            errorMessage.show()
        } else if (username!.isEmpty) {
            var errorMessage = UIAlertView(title: "Try again", message: "Username cannot be empty", delegate: self, cancelButtonTitle: "OK")
            errorMessage.show()
        } else if (username!.characters.count) < 2 {
            var errorMessage = UIAlertView(title: "Try again", message: "Username must be longer than 2 symbols.", delegate: self, cancelButtonTitle: "OK")
        } else {
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            var newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
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
