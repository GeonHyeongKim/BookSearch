//
//  BookViewModel.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation

final class BookViewModel: ObservableObject {
	// MARK: Property Wrapper
	@Published var book: [Book]
	@Published var totalPageInfo: Int = 1 	// 전체 페이지 수
	@Published var isLoading = false		// 검색 loading
	
	// MARK: Property
	private var currentPage: Int = 1		// 현재 페이지 수

	init (book: [Book] = []) {
		self.book = book
	}
	
	// 데이터를 가져올때
	func fetchData(searchText queryString: String, page: Int = 1) async throws -> BookResponse? {
		guard let url = URL(string: APIConstants.Path.searchPath + queryString.replacingOccurrences(of: " ", with: "+") + "&page=\(page)") else { return nil }
		
		let (data, _) = try await URLSession.shared.data(from: url)
		let result = try JSONDecoder().decode(BookResponse.self, from: data)
		
		return result
	}
	
	// Pagenation
	func fetchMore(searchText queryString: String) async throws -> [Book] {
		if self.currentPage + 1 == totalPageInfo { // 마지막 페이지 일때
			return []
		}

		self.currentPage += 1 // 다음 페이지
		
		guard let result = try await fetchData(searchText: queryString, page: currentPage) else { return [] }
		
		return result.docs
	}
}
