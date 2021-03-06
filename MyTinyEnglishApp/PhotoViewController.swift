//
//  PhotoViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/3/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    var chosenImage: UIImage!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var charmyKitty: UIImageView!
    @IBOutlet weak var userTextInput: UITextField!
    @IBOutlet weak var myPhotoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        userTextInput.delegate = self
        
        self.animateImage()
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
    
    func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint)->UIImage{
        
        let textColor: UIColor = UIColor.yellowColor()
        let textFont: UIFont = UIFont(name: "Helvetica Bold", size: 200)!
        
        UIGraphicsBeginImageContext(inImage.size)

        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        let rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)

        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    @IBAction func savePhoto(sender: AnyObject) {
        let userInput = userTextInput.text
        let newImage = textToImage(userInput!, inImage: chosenImage, atPoint: CGPointMake(20, 20))
        myPhotoView.image = newImage
        
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    }
    
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func animateImage() {
        UIView.animateWithDuration(0.75, delay: 0.50, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.charmyKitty.alpha = 1
            
            self.charmyKitty.center.x = 1
            }, completion: nil)
    }

}
