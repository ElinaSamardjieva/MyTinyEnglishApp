//
//  LibraryViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/3/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var textField: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func searchWordInDictionary(sender: AnyObject) {
        let dictionary = Lexicontext.sharedDictionary()
        let userWord = textInput.text
        let definition = dictionary.definitionFor(userWord)
        textField.text = definition
        
        //Add scroll bar
       textField.flashScrollIndicators()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
