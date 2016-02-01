//
//  Validator.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/1/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class Validator: NSObject {

    let message = Message()
    var isValid = true
    var textError = ""
    
    func validateEmail(inputStr:String) -> Bool {
        
        if(inputStr.isEmpty){
            textError = "Email field cannot be empty!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        
        if(!(isValidEmail(inputStr))){
            textError = "The input is invalid email!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        
        return isValid
    }
    
    func validateUsername(inputStr:String) -> Bool {
      
        if(inputStr.isEmpty) {
            textError = "Username field cannot be empty!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        } else if(inputStr.characters.count < 2){
            textError = "Username must be longer than 2 symbols!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        return isValid
    }

    func validatePassword(inputStr:String) -> Bool {
        
        if(inputStr.isEmpty) {
            textError = "Password field cannot be empty!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        return isValid
    }
    
    func validateConfirmPassword(inputStr:String) -> Bool {
        
        if(inputStr.isEmpty) {
            textError = "Confirm password field cannot be empty!"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        return isValid
    }
    
    func validateArePasswordsEqual(inputPassword:String, inputConfirmPassword:String) -> Bool {
        if(inputPassword != inputConfirmPassword){
            textError = "Passwords do not match"
            message.showErrorMessage(textError)
            isValid = false
            return isValid
        }
        return isValid
    }

}

func isValidEmail(inputStr:String) -> Bool {
    let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(inputStr)
}

