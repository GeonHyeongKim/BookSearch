//
//  TextFieldClearButton.swift
//  BookSearch
//
//  Created by geonhyeong on 2023/07/05.
//

import SwiftUI

// MARK: - TextFiled에 x 버튼으로 Clear
struct TextFieldClearButton: ViewModifier {
	@Binding var text: String
	
	func body(content: Content) -> some View {
		HStack {
			content
			
			if !text.isEmpty {
				Button(action: {
					self.text = ""
				}) {
					Image(systemName: "xmark.circle")
						.foregroundColor(Color(UIColor.opaqueSeparator))
				}
			}
		}
	}
}
