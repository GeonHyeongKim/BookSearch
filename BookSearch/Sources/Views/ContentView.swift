//
//  ContentView.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		NavigationView {
			BookListView()
		} // NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
