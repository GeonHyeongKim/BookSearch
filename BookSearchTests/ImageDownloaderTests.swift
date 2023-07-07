//
//  ImageDownloaderTests.swift
//  BookSearchTests
//
//  Created by geonhyeong on 2023/07/07.
//

import XCTest
@testable import BookSearch

final class ImageDownloaderTests: XCTestCase {

	var sut: ImageDownloader! // 테스트 대상
	
	override func setUp() {
		super.setUp()
		
		sut = ImageDownloader.shared
	}
	
	override func tearDown() {
		sut = nil
		
		super.tearDown()
	}
	
	// image에 올바른 query를 호출할때
	func test_image_WhenValidqueryProvided_ShouldReturnUIImage() async throws {
		let urlPath = 9255566
		let size = ImageDownloader.Size.S

		let image = try await sut.image(from: urlPath, size: size)
		XCTAssertNotNil(image)
	}
	
	// image에 존재하지 않는 cover_i를 호출할때
	func test_image_WhenInValidCover_i_Provided_ShouldCatchError() async throws {
		let urlPath = Int.max // 올바르지 않는 커버 이미지
		let size = ImageDownloader.Size.S

		do {
			let _ = try await sut.image(from: urlPath, size: size)
		} catch {
			XCTAssertEqual(error as! ImageDownloadError, ImageDownloadError.invalidServerResponse)
		}
	}
}
