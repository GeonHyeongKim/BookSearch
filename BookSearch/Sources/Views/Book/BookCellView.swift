//
//  BookCellView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import SwiftUI

struct BookCellView: View {
	//MARK: Property Wrapper
	@State private var thumbnail: UIImage?
	@State private var isLoading = true

	// MARK: - Properties
	let book: Book

    var body: some View {
		NavigationLink(destination: BookDetailView(book: book, thumbnail: thumbnail)) {
			HStack {
				Group {
					if let image = thumbnail {
						Image(uiImage: image)
							.resizable()
							.scaledToFit()
					} else {
						ZStack {
							Rectangle()
								.fill(.clear)
								.border(.gray)
							
							if isLoading {
								ProgressView()
							} else {
								Text("이미지 없음")
									.foregroundColor(.gray)
									.font(.footnote)
							}
						} // ZStack
					}
				} // Group
				.frame(width: 50, height: 100)
				
				Text(book.title ?? "제목 없음")
					.foregroundColor(.black)
					.multilineTextAlignment(.leading)
				
				Spacer()
			} // HStack
		} // NavigationLink
		.onAppear {
			Task {
				do {
					if let image = try await ImageDownloader.shared.image(from: book.cover_i) {
						self.thumbnail = image
					}
				} catch {
					print("Error", #file, #function, #line, error)
				}
				isLoading = false
			} // Task
		} // onAppear
    }
}

struct BookCellView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			BookCellView(book: Book.getDummy())
		}
    }
}
