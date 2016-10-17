//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Wesley Austin on 8/22/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var journal: Journal? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entriesSet = journal?.entries,
            let entries = Array(entriesSet) as? [Entry] else { return 0 }
        
        return entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        guard let entriesSet = journal?.entries,
            let entries = Array(entriesSet) as? [Entry] else { return cell }
        
        
        // grab the entry for the cell
        let entry = entries[indexPath.row]
        
        // Set cell properties
        cell.textLabel?.text = entry.title
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(entry.timeStamp!)
        

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete entry from singleton
            guard let entriesSet = journal?.entries,
                let entries = Array(entriesSet) as? [Entry] else { return }
            
            let entry = entries[indexPath.row]
            
            JournalController.sharedController.removeEntryFromJournal(entry)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "showDetail" {
            let entryDetailViewController = segue.destinationViewController as! EntryDetailViewController
            
            // Pass along the proper entry to EntryDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let entriesSet = journal?.entries,
                    let entries = Array(entriesSet) as? [Entry] else { return }
                
                let selectedEntry = entries[indexPath.row]
                entryDetailViewController.entry = selectedEntry
            }
        } else if segue.identifier == "addEntry" {
            let entryDetailViewController = segue.destinationViewController as! EntryDetailViewController
            
            entryDetailViewController.journal = journal
        }
    }
}
