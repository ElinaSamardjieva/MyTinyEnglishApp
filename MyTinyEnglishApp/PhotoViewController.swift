//
//  PhotoViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/3/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var charmyKitty: UIImageView!
    
    @IBOutlet weak var userTextInput: UITextField!


    @IBOutlet weak var myPhotoView: UIImageView!
    
    var chosenImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        userTextInput.delegate = self
        
        UIView.animateWithDuration(0.75, delay: 0.50, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.charmyKitty.alpha = 1
            
            self.charmyKitty.center.x = 1
            }, completion: nil)
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        var userInput = userTextInput.text
        var newImage = textToImage(userInput!, inImage: chosenImage, atPoint: CGPointMake(20, 20))
        myPhotoView.image = newImage
        
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    }


    @IBAction func openGallery(sender: AnyObject) {
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }

    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            presentViewController(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //DELEGATES
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myPhotoView.contentMode = .ScaleAspectFit
        myPhotoView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        var textColor: UIColor = UIColor.yellowColor()
        var textFont: UIFont = UIFont(name: "Helvetica Bold", size: 200)!
        
        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
        
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC,
            animated: true,
            completion: nil)
    }
    
    //Disable keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
