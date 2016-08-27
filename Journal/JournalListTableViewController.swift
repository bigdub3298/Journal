//
//  JournalListTableViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/23/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        tableView.allowsSelectionDuringEditing = true
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
            performSegueWithIdentifier("editJournal", sender: nil)
        }
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
        } else if segue.identifier == "editJournal" {
            let addJournalViewController = segue.destinationViewController as! AddJournalViewController
            if let selectedCell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(selectedCell) {
                let selectedJournal = JournalController.sharedController.journals[indexPath.row]
                addJournalViewController.journal = selectedJournal
            }
            
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "showEntries" || identifier == "addJournal") && tableView.editing {
            return false
        } else {
            return true 
        }
    }
    
    @IBAction func unwindToJournalListView(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? AddJournalViewController, let journal = sourceViewController.journal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update tableviewcell 
                JournalController.sharedController.journals[selectedIndexPath.row] = journal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add new journal entry to tableview 
                let newIndexPath = NSIndexPath(forRow: JournalController.sharedController.journals.count, inSection: 0)
                JournalController.sharedController.addJournal(journal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save journals
            JournalController.sharedController.saveJournals()
        }
    }
    
 

}


















