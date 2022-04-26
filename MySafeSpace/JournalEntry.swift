//
//  JournalEntry.swift
//  MySafeSpace
//
//  Created by user217582 on 4/25/22.
//

import Foundation
import RealmSwift

class JournaEntry: Object {
    @Persisted var title: String = ""
    @Persisted var text: String = ""
    @Persisted var dateAdded: String = ""
    @Persisted(originProperty: "journalEntries") var user: LinkingObjects<User>
}
