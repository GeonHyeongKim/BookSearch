//
//  BookDetailView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import SwiftUI

struct BookDetailView: View {
	// MARK: - Properties
	let book: Book
	let thumbnail: UIImage?

    var body: some View {
		Form {
			Section(header: Text("책 정보 (커버, 제목/연도, 저자)")) {
				if let image = thumbnail {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.padding()
					
				} else {
					Text("커버 이미지 없음")
						.foregroundColor(.gray)
						.font(.footnote)
				}
				
				// 제목, 연도
				HStack {
					Text(book.title ?? "제목 없음")
					
					Text("/")
					
					Text("(\(book.first_publish_year ?? 0))")
						.foregroundColor(.secondary)
				}
				.font(.headline)
				
				// 저자
				HStack(alignment: .top) {
					Text(book.author_name?.first ?? "저자 없음")
						.font(.body)
					
					Text(book.author_name?.count ?? 0 > 1 ? "외 \((book.author_name?.count ?? 0) - 1)명" : "")
				} // HStack
			} // Section
			
			Section(header: Text("출판사")) {
				// 출판사
				ForEach(book.publisher ?? [], id: \.self) { publisher in
					Text(publisher)
				}.font(.body)
			} // Section
		} // Form
		.navigationTitle("상세 화면")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			BookDetailView(book: Book.getDummy(), thumbnail: nil)
		} // NavigationView
    }
}
