//
//  SearchBar.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 06/03/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $text)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var previewText = "initial value"
    static var previews: some View {
        
        SearchBar(text: $previewText, placeholder: "placeholder")
    }
}
