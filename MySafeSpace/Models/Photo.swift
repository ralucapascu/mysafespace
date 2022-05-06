//
//  Photo.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import Foundation
import RealmSwift

class Photo: Object {
	@Persisted var journalId: Int = 0
	@Persisted var photoDescription: String = ""
	@Persisted(originProperty: "journalPhotos") var journal: LinkingObjects<JournaEntry>
}
