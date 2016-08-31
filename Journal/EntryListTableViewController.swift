//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/22/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var entries: [Entry]?
    var journalIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let entries = entries else {
            return 0
        }
        return entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        guard let entries = entries else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = "" 
            return cell
        }
        // grab the entry for the cell
        let entry = entries[indexPath.row]
        
        // Set cell properties
        cell.textLabel?.text = entry.title
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(entry.timeStamp)
        

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete entry from singleton
            let entry = entries![indexPath.row]
            deleteEntry(entry)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let selectedJournal = JournalController.sharedController.journals[journalIndexPath!.row]
            selectedJournal.entries = entries!
            JournalController.sharedController.saveJournals()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "showDetail" {
            let entryDetailViewController = segue.destinationViewController as! EntryDetailViewController
            
            // Pass along the proper entry to EntryDetailViewController
            if let selectedCell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(selectedCell) {
                let selectedEntry = entries![indexPath.row]
                entryDetailViewController.entry = selectedEntry
            }
        } else if segue.identifier == "addEntry" {
            // do nothing
        }
    }
    
    @IBAction func unwindtoEntryList(sender: UIStoryboardSegue) {
        
        //  Get source view and entry
        if let sourceViewController = sender.sourceViewController as? EntryDetailViewController, let entry = sourceViewController.entry {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                // Update entry
                entries![selectedIndexPath.row] = entry
                // Reload cell
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Create index path for new entry
                let newIndexPath = NSIndexPath(forRow: entries!.count, inSection: 0)
                addEntry(entry)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save entries 
            let selectedJournal = JournalController.sharedController.journals[journalIndexPath!.row]
            selectedJournal.entries = entries!
            JournalController.sharedController.saveJournals()
        }
    }
    
    // MARK: - Helper
    func deleteEntry(entry: Entry) {
        if let index = entries!.indexOf(entry) {
            entries!.removeAtIndex(index)
        }
    }
    
    func addEntry(entry: Entry) {
        entries!.append(entry)
    }

}
