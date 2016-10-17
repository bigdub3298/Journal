//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/22/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

   
   
    @IBOutlet weak var titleBarItem: UINavigationItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    var entry: Entry?
    var journal: Journal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign textField and textView delegates to self
        titleTextField.delegate = self
        bodyTextView.delegate = self
        
        if let entry = entry {
            // update view items
            updateWith(entry) 
        }
        
        checkValidTitle()
        checkValidBody()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTitle()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable save button while editing
        saveButton.enabled = false
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        // Hide the keyboard
        textView.resignFirstResponder()
        checkValidBody()
    }
    
    func checkValidTitle() {
        let title = titleTextField.text ?? ""
        saveButton.enabled = !title.isEmpty
    }
    
    func checkValidBody() {
        let bodyText = bodyTextView.text ?? ""
        saveButton.enabled = !bodyText.isEmpty
    }
    
    // MARK: - Actions 
    
    @IBAction func clearButton(sender: AnyObject) {
        titleTextField.text = ""
        bodyTextView.text = ""
        titleBarItem.title = "Title" 
    }

    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        let title = titleTextField.text ?? ""
        let bodyText = bodyTextView.text ?? ""
        
        if let entry = entry {
            JournalController.sharedController.updateEntry(entry, title: title, bodyText: bodyText)
        } else {
            JournalController.sharedController.addEntryToJournal(title, bodyText: bodyText, journal: journal!)
        }
    }


    // MARK: - Helper funcitons 
    
    func updateWith(entry: Entry) {
        titleBarItem.title = entry.title
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
}
