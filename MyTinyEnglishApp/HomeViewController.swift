//
//  ViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/1/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit
import Parse
import QuartzCore

class HomeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var charmyKitty: UIImageView!
    
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pUserName = PFUser.currentUser()?["username"] as? String {
            self.usernameLabel.text = "Welcome, " + pUserName + "!"
        }

        self.animateImage()
    }

    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    func animateImage() {
        UIView.animateWithDuration(0.75, delay: 0.50, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.charmyKitty.alpha = 1
            self.charmyKitty.center.x = 1
            }, completion: nil)
    }
}
