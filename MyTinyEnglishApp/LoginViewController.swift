//
//  LoginViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/1/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.autocorrectionType = .No
    }

    @IBAction func loginAction(sender: AnyObject) {

        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in

            spinner.stopAnimating()
            
            if ((user) != nil) {
                let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                   
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController : HomeViewController = storyboard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
                    let navigationController = UINavigationController(rootViewController: viewController)
                    self.presentViewController(navigationController, animated: true, completion: nil)
                })
                
            } else {
                      let alert = UIAlertController(title:"Error", message:"Invalid username or password, please try again", preferredStyle: .Alert)
                      let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                      alert.addAction(alertAction)
                      self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
}
