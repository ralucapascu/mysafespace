//
//  JournalEntryViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/27/22.
//

import UIKit

class JournalEntryViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var journalEntry: JournaEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = journalEntry.title
        textView.text = journalEntry.text
    }
}
