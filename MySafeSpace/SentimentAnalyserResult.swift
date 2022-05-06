//
//  SentimentAnalyserResult.swift
//  MySafeSpace
//
//  Created by user217582 on 5/6/22.
//

import Foundation

struct SentimentAnalyser: Codable {
	let pos_percent: String
	let neg_percent: String
	let mid_percent: String
	let pos: Float
	let neg: Float
	let mid: Float
	let text: String
}
