//
//  BookListView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

struct BookListView: View {
	//MARK: Property Wrapper

    var body: some View {
		VStack {
			
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
