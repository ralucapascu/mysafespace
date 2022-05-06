//
//  JournalEntriesViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/27/22.
//

import UIKit

class JournalEntriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        
        if !currentUser.journalEntries.isEmpty {
            label.isHidden = true
            table.isHidden = false
        }
    }
    
    @IBAction func didTapAddJournalEntryButton(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "newEntryVC") as! NewJournalEntryViewController
        viewController.currentUser = currentUser
        viewController.title = "New journal entry"
        viewController.completion = {
            updatedUser in
            self.currentUser = updatedUser
            if !self.currentUser.journalEntries.isEmpty {
                self.label.isHidden = true
                self.table.isHidden = false
                self.table.reloadData()
            }
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let index = currentUser.journalEntries.count - indexPath.row - 1
        cell.textLabel?.text = currentUser.journalEntries[index].dateAdded + " - " + currentUser.journalEntries[index].title
        cell.detailTextLabel?.text = currentUser.journalEntries[index].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "journalEntryVC") as! JournalEntryViewController
        viewController.journalEntry = currentUser.journalEntries[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
