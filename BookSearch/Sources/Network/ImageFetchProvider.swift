//
//  ImageFetchProvider.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import UIKit

struct ImageFetchProvider {
	// MARK: Property
	static let shared = ImageFetchProvider()
	
	/// URL 을 가지고 data 를 다운받아서 UIImage 로 변환하는 메서드.
	/// - Parameter url: 다운받을 URL 값.
	/// - Returns: 다운 받은 data 를 UIImage 로 변환해서 리턴. 변환되지 않는 경우 에러 반환.
	public func fetchImage(with url: URL) async throws -> UIImage {
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw ImageDownloadError.invalidServerResponse
		}
		
		guard let image = UIImage(data: data) else {
			throw ImageDownloadError.unsupportImage
		}
		
		return image
	}
}
