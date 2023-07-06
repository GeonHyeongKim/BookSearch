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

    var body: some View {
		VStack {
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
		}
		.padding()
		.navigationTitle("상세 화면")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			BookDetailView(book: Book.getDummy())
		} // NavigationView
    }
}
