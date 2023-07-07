//
//  ImageFetchProviderTests.swift
//  ImageFetchProviderTests
//
//  Created by geonhyeong on 2023/07/07.
//

import XCTest
@testable import BookSearch

final class ImageFetchProviderTests: XCTestCase {

	var sut: ImageFetchProvider! // 테스트 대상
	
	override func setUp() {
		super.setUp()
		
		sut = ImageFetchProvider()
	}
	
	override func tearDown() {
		sut = nil
		
		super.tearDown()
	}
	
	// fetchImage에 올바른 URL를 호출할때
	func test_fetchImage_WhenValidURLProvided_ShouldReturnUIImage() async throws {
		let urlPath = 9255566
		let size = ImageDownloader.Size.S
		let urlString = APIConstants.Path.imageURLPath + "\(urlPath)-\(size).jpg"
		let imageURL = URL(string: urlString)!

		let image = try await sut.fetchImage(with: imageURL)
		XCTAssertNotNil(image)
	}
	
	// fetchImage에 존재하지 않는 cover_i를 호출할때
	func test_fetchImage_WhenInValidCover_i_Provided_ShouldCatchError() async throws {
		let urlPath = Int.max // 올바르지 않는 커버 이미지
		let size = ImageDownloader.Size.S
		let urlString = APIConstants.Path.imageURLPath + "\(urlPath)-\(size).jpg"
		let imageURL = URL(string: urlString)!

		do {
			let _ = try await sut.fetchImage(with: imageURL)
		} catch {
			XCTAssertEqual(error as! ImageDownloadError, ImageDownloadError.invalidServerResponse)
		}
	}
	
	// fetchImage에 올바르지 않는 URL(확장자를 붙이지 않을 경우)을 호출할때
	func test_fetchImage_WhenInValidURLProvided_ShouldCatchError() async throws {
		let urlPath = Int.max // 올바르지 않는 커버 이미지
		let size = ImageDownloader.Size.S
		let urlString = APIConstants.Path.imageURLPath + "\(urlPath)-\(size)"
		let imageURL = URL(string: urlString)!

		do {
			let _ = try await sut.fetchImage(with: imageURL)
		} catch {
			XCTAssertEqual(error as! ImageDownloadError, ImageDownloadError.invalidServerResponse)
		}
	}
}
