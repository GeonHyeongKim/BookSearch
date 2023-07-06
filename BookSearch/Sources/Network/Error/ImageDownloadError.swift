//
//  ImageDownloadError.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import Foundation

public enum ImageDownloadError: Error {
	case invalidURLString		// 유효하지 않는 URL
	case invalidServerResponse	// 유효하지 않는 서버 응답
	case unsupportImage			// 지원되지 않는 이미지
}
