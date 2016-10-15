//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/23/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController, UITextFieldDelegate {

    var journalIndexPath: NSIndexPath?
    var previousTitle: String?
    var editSaveAction: UIAlertAction?
    var addSaveAction: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // allow sellection of cells during editing 
        tableView.allowsSelectionDuringEditing = true
        
        editSaveAction?.enabled = false
        addSaveAction?.enabled = false
        
        // Load saved journals
        if let savedJournals = JournalController.sharedController.loadJournals() {
            JournalController.sharedController.journals += savedJournals
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.sharedController.journals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("journalCell", forIndexPath: indexPath)

        let journal = JournalController.sharedController.journals[indexPath.row]
        // Set cell text to journal title
        cell.textLabel?.text = journal.title

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let journal = JournalController.sharedController.journals[indexPath.row]
            // delete journal
            JournalController.sharedController.deleteJournal(journal)
            // update tableview
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            // save journals
            JournalController.sharedController.saveJournals()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.editing {
            let journal = JournalController.sharedController.journals[indexPath.row]
            previousTitle = journal.title
            
            let editAlert = UIAlertController(title: "Change Title", message: nil, preferredStyle: .Alert)
            
            // Cancel Alert
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            // Save Journal Title
            let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (_) -> Void in
                let textField = editAlert.textFields![0]
                
                // check to see if the user has altered the title
                if textField.text != journal.title {
                    //check text value
                    journal.title = textField.text ?? ""
                    
                    //set journal
                    JournalController.sharedController.journals[indexPath.row] = journal
                    
                    // save journals
                    JournalController.sharedController.saveJournals()
                    tableView.reloadData()
                }
            })
            
            // Add actions to alert controller
            editAlert.addAction(cancelAction)
            editAlert.addAction(saveAction)
            
            // set class variable
            editSaveAction = editAlert.actions[1]
            
            // Sets the text to the journal title if
            editAlert.addTextFieldWithConfigurationHandler({(textField) -> Void in
                textField.text = journal.title
                textField.delegate = self
            })
            
            self.presentViewController(editAlert, animated: true, completion: nil)
        }
    }

    
    // MARK: - TextFieldDelegate 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    func textFieldDidBeginEditing(textField: UITextField) {
        editSaveAction?.enabled = false
        addSaveAction?.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            editSaveAction?.enabled = true
        }
        addSaveAction?.enabled = true
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEntries" {
            let entryListTableViewController = segue.destinationViewController as! EntryListTableViewController
            
            if let selectedCell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(selectedCell) {
                // get selected Journal
                let selectedJournal = JournalController.sharedController.journals[indexPath.row]
                
                // pass entry and journal indexPath to EntryListTableViewController
                entryListTableViewController.entries = selectedJournal.entries
                entryListTableViewController.journalIndexPath = indexPath
            }
        } else if segue.identifier == "addJournal" {
            // do nothing 
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "showEntries" || identifier == "addJournal") && tableView.editing {
            return false
        } else {
            return true 
        }
    }
    
    // MARK: - Actions 
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        let addAlert = UIAlertController(title: "Add Journal", message: nil, preferredStyle: .Alert)
        
        // Cancel Alert
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        // Save Journal Title
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (_) -> Void in
            let textField = addAlert.textFields![0]
            
            let newJournalTitle = textField.text ?? ""
            
            let newJournal = Journal(title: newJournalTitle, entries: [])
            let newIndexPath = NSIndexPath(forRow: JournalController.sharedController.journals.count, inSection: 0)
            
            JournalController.sharedController.addJournal(newJournal)
            
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        })
        
        addAlert.addAction(cancelAction)
        addAlert.addAction(saveAction)
        
        addSaveAction = addAlert.actions[1]
    
        addAlert.addTextFieldWithConfigurationHandler { (textField) in
            textField.delegate = self
        }
        
        self.presentViewController(addAlert, animated: true, completion: nil)
    }
    
}


















