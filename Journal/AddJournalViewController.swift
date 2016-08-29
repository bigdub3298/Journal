//
//  AddJournalViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/24/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class AddJournalViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleBarItem: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set delegate to AddJournalviewController
        titleTextField.delegate = self
        
        if let journal = journal {
            updateTitle(journal) 
        }
        
        checkValidTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide keyboard
        titleTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTitle()
    }
    
    func checkValidTitle() {
        let text = titleTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    
    func updateTitle(journal: Journal) {
        titleBarItem.title = journal.title
        titleTextField.text = journal.title
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let title = titleTextField.text ?? "" 
            
            journal = Journal(title: title, entries: [Entry]())
        }
    }


}
