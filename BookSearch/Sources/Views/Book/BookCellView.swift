//
//  BookCellView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/06.
//

import SwiftUI

struct BookCellView: View {
	// MARK: - Properties
	let book: Book
	@State private var image: UIImage?
	
    var body: some View {
		NavigationLink(destination: EmptyView()) {
			HStack {
				Group {
					if let image = image {
						Image(uiImage: image)
							.resizable()
							.scaledToFit()
					} else {
						Rectangle()
							.fill(.clear)
							.border(.gray)
					}
				} // Group
				.frame(width: 50, height: 100)
				
				Text(book.title ?? "제목 없음")
					.foregroundColor(.black)
					
				Spacer()
			} // HStack
		} // NavigationLink
		.onAppear {
			Task {
				do {
					if let image = try await ImageDownloader.shared.image(from: book.cover_i) {
						self.image = image
					}
				} catch {
					print(error)
				}
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
