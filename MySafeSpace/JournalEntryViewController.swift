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
    
    var journalEntry: JournalEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = journalEntry.dateAdded
        titleLabel.text = journalEntry.title
        textView.text = journalEntry.text
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go to gallery", style: .done, target: self, action: #selector(didTapGoToGalleryButton))
    }
	
	@objc func didTapGoToGalleryButton() {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "galleryVC") as! JournalGalleryViewController
		viewController.journalEntry = self.journalEntry
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
