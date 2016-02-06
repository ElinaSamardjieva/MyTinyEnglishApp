//
//  LibraryViewController.swift
//  MyTinyEnglishApp
//
//  Created by Elina on 2/3/16.
//  Copyright © 2016 Elina. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!

    @IBOutlet weak var textField: UITextView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchWordInDictionary(sender: AnyObject) {
        let dictionary = Lexicontext.sharedDictionary()
        //   let definition = dictionary.definitionFor("apple")
        let userWord = textInput.text
        let definition = dictionary.definitionFor(userWord)
        //   print("The definition of \'apple' is: \n\n\(definition)\n\n")
        textField.text = definition
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
