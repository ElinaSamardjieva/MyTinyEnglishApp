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

        //Turning off the Autocorrection
        usernameTextField.autocorrectionType = .No
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginAction(sender: AnyObject) {

        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        //TODO: see again
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        // Send a request to login
        PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
            
            // Stop the spinner
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
                let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
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
