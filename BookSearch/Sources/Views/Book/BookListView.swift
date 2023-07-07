//
//  BookListView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

struct BookListView: View {
	// MARK: Property Wrapper
	@StateObject private var viewModel: BookViewModel = BookViewModel()
	@State private var searchText = ""
	
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundColor(.red)
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
						ForEach(Array(viewModel.book.enumerated()), id: \.offset) { index, book in
							BookCellView(book: book)
								.onAppear {
									if index == viewModel.book.count - 1 { // 맨 마지막
										Task {
											viewModel.isLoading = true
											let result = try await viewModel.fetchMore(searchText: searchText)
											viewModel.book += result // pagenation
											viewModel.isLoading = false
										} // Task
									}
								} // onAppear
						} // ForEach
					} // LazyVStack
				} // ScrollView
				.padding(.top)
				
				// 로딩 중일 경우
				if viewModel.isLoading {
					ProgressView()
						.scaleEffect(2)
				}
			} // ZStack
		} // VStack
		.padding()
		.navigationTitle("검색 화면")
		.navigationBarTitleDisplayMode(.inline)
    }
	
	func searchBookList() {
		Task {
			viewModel.isLoading = true // 로딩 시작
			if let result = try await viewModel.fetchData(searchText: searchText) {
				viewModel.book = result.docs
				viewModel.totalPageInfo = result.num_found / 100 + (result.num_found % 100 > 0 ? 1 : 0) // 100 단위로 받음, 나머지가 존재할 경우 반올림
			}
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
