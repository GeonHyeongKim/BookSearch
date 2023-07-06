//
//  APIConstants.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation

struct APIConstants {
	static let baseURL = "https://openlibrary.org/"
	static let coverBaseURL = "https://covers.openlibrary.org/"

	struct Path {
		static let searchPath = baseURL + "search.json?q="
		static let imageURLPath = coverBaseURL + "b/id/"
	}
}
