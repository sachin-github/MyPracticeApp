//
//  PostTile.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

import SwiftUI

struct PostTile: View {
    private let tileColor: CGColor = CGColor(red: 100,
                                             green: 100,
                                             blue: 100,
                                             alpha: 0.8)
    
    @State
    var imageTitle = "Image title"
    
    @State
    var url = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(cgColor: tileColor))
                .shadow(radius: 5)
            
            VStack {
                HStack {
                    Text(imageTitle)
                        .font(.title3)
                        .fontWeight(.light)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                
                        } placeholder: {
                            Color(red: 100, green: 100, blue: 100)
                        }
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 500, alignment: .center)
        .padding()
    }
}

struct PostTile_Previews: PreviewProvider {
    static var previews: some View {
        PostTile()
    }
}
