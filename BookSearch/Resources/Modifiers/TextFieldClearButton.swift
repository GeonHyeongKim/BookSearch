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
			
			if !text.isEmpty { // 비어 있지 않을 경우
				Button(action: {
					self.text = "" // 초기화
				}) {
					Image(systemName: "xmark.circle")
						.foregroundColor(Color(UIColor.opaqueSeparator))
				} // Button
			}
		}
	}
}
