//
//  SearchPage.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 06/03/23.
//

import SwiftUI

struct SearchPage: View {
    @State private var searchText = ""
    @State private var searchResults = ["Result-1", "Result-2", "Result-3"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SearchBar(text: $searchText, placeholder: "Search")
                
                List(searchResults, id: \.self) { result in
                    Text(result)
                }
            }
            .navigationBarTitle(Text("Search"))
        }
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
