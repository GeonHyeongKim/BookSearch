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

	// NSCache를 활용한 메로리 캐시 처리
	private var cache: NSCache<NSString, UIImage> = .init()
	
	enum Size {
		case S // 썸네일로 사용하기 적합
		case M // 세부 정보 페이지에 표시하기 적합
		case L
	}
	
	/// URL 을 기반으로 Cache 처리 및 UIImage 로 반환하는 메서드.
	/// - Parameters:
	///   - urlPath: 다운받을 cover_i  값.
	///   - size: Image의 크기
	/// - Returns: Cache에 저장되어 있는 UIImage를 반환. 변환되지 않는 경우 에러 반환.
	func image(from urlPath: Int?, size: Size = .M) async throws -> UIImage? {
		guard let urlPath = urlPath else {
			throw ImageDownloadError.invalidURLString
		}
		
		// URL Path
		let urlString = APIConstants.Path.imageURLPath + "\(urlPath)-\(size).jpg"
		
		guard let url = URL(string: urlString) else {
			throw ImageDownloadError.invalidURLString
		}
		
		// Cached Key 얻기
		let cachedKey = NSString(string: urlString)
				
		// 이미 다운 받은 URL 에 대해서 캐싱 처리
		if let cached = cache.object(forKey: cachedKey) {
			return cached
		}
		
		let image = try await downloadImage(from: url)

		// 캐싱되지 않은 경우만 thumbnail 로 변경
		cache.setObject(image, forKey: cachedKey)
		
		return image
	}

	/// 나이 더하기
	/// - Parameters:
	///   - a: a의 나이
	///   - b: b의 나이
	/// - Returns: 둘 나이의 합
	private func downloadImage(from url: URL) async throws -> UIImage {
		let imageFetchProvider = ImageFetchProvider.shared
		return try await imageFetchProvider.fetchImage(with: url)
	}
}
