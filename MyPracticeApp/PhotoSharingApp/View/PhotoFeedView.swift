//
//  PhotoFeedView.swift
//  MyPracticeApp
//
//  Created by Sachin Srivastava on 10/03/23.
//

import Combine
import SwiftUI

struct PhotoFeedView: View {
    @StateObject var feedViewModel = PhotoSharingFeedViewModelImpl()
    
    @State private var isLoading = false
    
    @State
    private var cancelBag = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            
            Text("Photo Feed")
                .font(.title)
                .fontWeight(.light)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            HStack {
                Text("Count of records: \(feedViewModel.feedViewData.count)")
                Button("Refresh") {
                    feedViewModel.generateNextFeed()
                }
            }
            
            List {
                ForEach(feedViewModel.feedViewData, id: \.self) { item in
                    PostTile(imageTitle: item.title, url: item.url)
                        .id(item.id)
                        .onAppear {
                            let totalItems = feedViewModel.feedViewData.count
                            let refreshAtItem = totalItems > 5 ? totalItems - 3 : totalItems
                            
                            if item == feedViewModel.feedViewData[refreshAtItem] {
                                getFeed()
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .onAppear {
                getFeed()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func getFeed() {
        
        isLoading = true
        feedViewModel.generateNextFeed()
    }
}

struct PhotoFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoFeedView()
    }
}

// MARK: Old code `body` property
/*
 var body: some View {
     VStack {
         
         Text("Photo Feed")
             .font(.title)
             .fontWeight(.light)
             .shadow(radius: 5)
             .frame(maxWidth: .infinity, alignment: .leading)
             .padding()
         
         HStack {
             Text("Count of records: \(feedViewModel.feedViewData.count)")
             Button("Refresh") {
                 feedViewModel.generateNextFeed()
             }
         }
         
//            ScrollView {
//                VStack {
//
//                    ForEach(feedViewModel.feedViewData, id: \.self) { item in
//                        PostTile(imageTitle: item.title, url: item.url)
//                    }
//
//                    if isLoading {
//                        ProgressView()
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .padding()
//                    }
//                }
//            }
//            .scrollIndicators(.hidden)
         
         List {
             ForEach(feedViewModel.feedViewData, id: \.self) { item in
                 PostTile(imageTitle: item.title, url: item.url)
                     .id(item.id)
                     .onAppear {
                         let totalItems = feedViewModel.feedViewData.count
                         let refreshAtItem = totalItems > 5 ? totalItems - 3 : totalItems
                         
                         if item == feedViewModel.feedViewData[refreshAtItem] {
                             getFeed()
                         }
                     }
             }
         }
         .frame(maxWidth: .infinity)
//            .foregroundColor(.white)
         .scrollIndicators(.hidden)
         .onAppear {
             getFeed()
         }
         
     }
     .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .padding()
//        .onAppear {
//            getFeed()
//        }
 }
 */
