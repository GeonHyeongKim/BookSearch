//
//  BookViewModel.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation

class BookViewModel: ObservableObject {
	//MARK: Property Wrapper
	@Published var book: [Book]
	@Published var pageInfo: Int = 1 // 현재 페이지
	
	init (book: [Book] = []) {
		self.book = book
	}
	
	// 처음 데이터를 가져올때
	func fetchData(searchText queryString: String) async throws -> [Book] {
		guard let url = URL(string: APIConstants.Path.searchPath + queryString.replacingOccurrences(of: " ", with: "+") + "&page=\(pageInfo)") else { return [] }
		
		let (data, _) = try await URLSession.shared.data(from: url)
		let result = try JSONDecoder().decode(BookResponse.self, from: data)
		
		return result.docs
	}
}
