//
//  ContentView.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 06/03/23.
//

import SwiftUI

struct ContentView: View {
    
    private var colors: [Color] = [.teal, .orange, .yellow, .cyan, .green]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Apps List")
                .fontDesign(.rounded)
                .font(.title)
                .padding()
                .shadow(radius: 10)
            
            NavigationView {
                ScrollView {
                    HStack(spacing: 20) {
                        NavigationLink(destination: SearchPage()) {
                            TileView(title: "Search App", color: colors[0])
                        }
                        .foregroundColor(.black)
                        
                        TileView(title: "Cache Example", color: colors[1])
                    }
                    .padding()
                    
                    HStack(spacing: 20) {
                        
                        NavigationLink(destination: PhotoFeedView()) {
                            TileView(title: "Photo sharing app", color: colors[2])
                        }
                        .foregroundColor(.black)
                        
                        TileView(title: "Some other app", color: colors[3])
                    }
                    .padding()
                }
                .padding(.top, 10)
                .scrollIndicators(.hidden)
            }
        }
//        .background(
//            Image("background")
//                .resizable()
//                .scaledToFill()
//        )
    }
}

struct TileView: View {
    @State var title = "Test title goes here"
    @State var color = Color.teal
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .shadow(radius: 5)
            
            VStack {
                Text(title)
                    .font(.title2)
                    .padding(10)
            }
        }
        .frame(width: 150, height: 150)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
