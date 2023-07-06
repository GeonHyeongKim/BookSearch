//
//  Book.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation

struct BookResponse: Codable, Hashable {
	let start: Int
	let num_found: Int
	let docs: [Book]
}

struct Book: Codable, Hashable {
	let cover_i: Int?				// 썸네일
	let title: String?				// 제목
	let author_name: [String]?		// 저자
	let publisher: [String]?		// 출판사
	let first_publish_year: Int?	// 첫 출판 연도
	
	static func getDummy() -> Self {
		return Book(cover_i: 9255566, title: "The Fellowship of the Ring", author_name: ["J.R.R. Tolkien"], publisher: ["Book on Demand Pod", "Mariner Books"], first_publish_year: 1954)
	}
}

