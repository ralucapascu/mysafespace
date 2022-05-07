//
//  JournalEntry.swift
//  MySafeSpace
//
//  Created by user217582 on 4/25/22.
//

import Foundation
import RealmSwift

class JournalEntry: Object {
	@Persisted var journalId: Int = 0
    @Persisted var title: String = ""
    @Persisted var text: String = ""
    @Persisted var dateAdded: String = ""
    @Persisted(originProperty: "journalEntries") var user: LinkingObjects<User>
	@Persisted var journalPhotos = RealmSwift.List<Photo>()
}
