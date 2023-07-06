//
//  BookListView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

struct BookListView: View {
	//MARK: Property Wrapper
	@StateObject private var viewModel: BookViewModel = BookViewModel()
	@State private var searchText = ""

    var body: some View {
		VStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundColor(Color.yellow)
					.padding(.leading, 10)
				
				TextField("검색어를 입력해주세요", text: $searchText, onCommit: {
					searchBookList() // 검색
				}).modifier(TextFieldClearButton(text: $searchText))
				
				Button {
					searchBookList() // 검색
				} label: {
					Text("검색")
						.foregroundColor(.white)
						.padding(6)
				} // Button
				.background(Color.green)
				.cornerRadius(5)
			} // HStack
			
			ZStack {
				ScrollView {
					LazyVStack {
						ForEach(viewModel.book, id: \.self) { book in
							BookCellView(book: book)
						} // ForEach
					} // LazyVStack
				} // ScrollView
				.padding(.top)
				
				if viewModel.isLoading {
					// 로딩 중일 경우
					ProgressView()
						.scaleEffect(2)
				}
			}
		} // VStack
		.padding()
		.navigationTitle("검색 화면")
		.navigationBarTitleDisplayMode(.inline)
    }
	
	func searchBookList() {
		Task {
			viewModel.isLoading = true // 로딩 시작
			let result = try await viewModel.fetchData(searchText: searchText)
			viewModel.book = result
			viewModel.isLoading = false // 로딩 종료
		} // Task
	}
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			BookListView()
		} // NavigationView
    }
}
