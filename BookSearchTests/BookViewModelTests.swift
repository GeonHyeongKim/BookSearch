//
//  BookViewModelTests.swift
//  BookViewModelTests
//
//  Created by geonhyeong on 2023/07/07.
//

import XCTest
@testable import BookSearch

final class BookViewModelTests: XCTestCase {
	var sut: BookViewModel! // 테스트 대상
	
	override func setUp() {
		super.setUp()
		
		sut = BookViewModel()
	}
	
	override func tearDown() {
		sut = nil
		
		super.tearDown()
	}
	
	// fetchData에 올바른 query를 호출할때
	func test_fetchData_WhenValidQueryProvided_ShouldReturnBookResponse() async throws {
		let searchText = "the lord of the rings"
		let page = 1
		
		do {
			let result = try await sut.fetchData(searchText: searchText, page: page)
			XCTAssertNotNil(result)
		} catch {
			XCTFail("Async error thrown: \(error)")
		}
	}
	
	// fetchData에 범위가 넘어가는 page를 호출할 경우
	func test_fetchData_WhenInValidPageProvided_ShouldReturnBookDecoderError() async throws {
		let searchText = "the lord of the rings"
		let page = Int.max // 범위를 넘김
		
		do {
			if let result = try await sut.fetchData(searchText: searchText, page: page) {
				XCTAssertTrue(result.docs.isEmpty)
			} else {
				XCTFail("Nil Response")
			}
		} catch { // 에러 발생
			XCTAssertTrue(true)
		}
	}
	
	// fetchMore(Pagenation)를 호출할 경우
	func test_fetchMore_WhenValidPageProvided_ShouldReturnBookResponse() async throws {
		let searchText = "the lord of the rings"
		
		do {
			let result = try await sut.fetchMore(searchText: searchText)
			XCTAssertFalse(result.isEmpty)
		} catch { // 에러 발생
			XCTFail("Async error thrown: \(error)")
		}
	}
}
