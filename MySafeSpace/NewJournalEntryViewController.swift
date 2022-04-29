//
//  NewJournalEntryViewController.swift
//  MySafeSpace
//
//  Created by user217582 on 4/27/22.
//

import UIKit
import RealmSwift

class NewJournalEntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var currentUser: User!
    let realm = try! Realm()
    
    public var completion: ((User) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField?.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        textView.delegate = self
        textView.text = "Type here..."
        textView.textColor = .white
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here..." {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type here..."
            textView.textColor = .white
        }
    }
    
    @objc func didTapSaveButton() {
        try! realm.write {
            let title = !titleField.text!.isEmpty ? titleField.text! : "No title"
            let text = textView.text!
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let journalEntry = JournaEntry()
            journalEntry.title = title
            journalEntry.text = text
            journalEntry.dateAdded = dateFormatter.string(from: date)
            
            currentUser.journalEntries.append(journalEntry)
            realm.add(currentUser)
        }
        completion(currentUser)
        self.navigationController?.popViewController(animated: true)
    }
}
