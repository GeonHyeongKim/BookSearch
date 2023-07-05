//
//  BookListView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

struct BookListView: View {
	//MARK: Property Wrapper
	@State private var searchText = ""

    var body: some View {
		VStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundColor(Color.black)
					.padding(.leading, 10)
				
				TextField("검색어를 입력해주세요", text: $searchText)
					.modifier(TextFieldClearButton(text: $searchText))
			} // HStack
		} // VStack
		.padding()
		.navigationTitle("검색 화면")
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			BookListView()
		} // NavigationView
    }
}
