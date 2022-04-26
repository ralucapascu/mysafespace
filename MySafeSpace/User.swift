//
//  User.swift
//  MySafeSpace
//
//  Created by user217582 on 4/23/22.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var email: String = ""
    @Persisted var password: String = ""
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var journalEntries = RealmSwift.List<JournaEntry>()
}
