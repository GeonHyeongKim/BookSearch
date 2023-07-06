//
//  ImageDownloader.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation
import SwiftUI

actor ImageDownloader {
	// MARK: Property
	// 캐싱 구현하기 위해서 싱글톤 패턴 사용
	static let shared = ImageDownloader()

	// Dictionary를 활용한 디스크 캐시 처리
	private var cache: [URL:UIImage] = [:]
	
	enum Size {
		case S // 썸네일로 사용하기 적합
		case M // 세부 정보 페이지에 표시하기 적합
		case L
	}
	
	func image(from urlPath: Int?, size: Size = .M) async throws -> UIImage? {
		guard let urlPath = urlPath, let url = URL(string: APIConstants.Path.imageURLPath + "\(urlPath)-\(size).jpg") else {
			throw ImageDownloadError.invalidURLString
		}
				
		// 이미 다운 받은 URL 에 대해서 캐싱 처리
		if let cached = cache[url] {
			return cached
		}
		
		let image = try await downloadImage(from: url)

		// 캐싱되지 않은 경우만 thumbnail 로 변경
		cache[url] = cache[url, default: image]
		
		return cache[url]
	}

	private func downloadImage(from url: URL) async throws -> UIImage {
		let imageFetchProvider = ImageFetchProvider.shared
		return try await imageFetchProvider.fetchImage(with: url)
	}
}
