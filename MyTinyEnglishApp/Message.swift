//
//  ErrorMessage.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/1/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    func showErrorMessage(inputStr:String) {
        var errorMessage = UIAlertView(title: "Try again", message: inputStr, delegate: self, cancelButtonTitle: "OK")
        errorMessage.show()
    }
}
