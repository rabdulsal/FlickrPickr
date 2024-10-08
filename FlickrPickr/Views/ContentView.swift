//
//  ContentView.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import SwiftUI

struct FPSearchBar: View {
    @Binding var searchText: String
    var onSearchTextChanged: () -> Void
    
    var body: some View {
        TextField("Search", text: $searchText)
        .onChange(of: searchText) { _,_ in
            onSearchTextChanged()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
}



struct ContentView: View {
    
    @StateObject private var picsViewModel = FPListViewModel()
    @State private var searchText = ""
    @Namespace private var namespace
    
    var body: some View {
        
        
        NavigationStack {
            
            VStack {
                
                // SearchBar
                FPSearchBar(searchText: $searchText) {
                    picsViewModel.searchImages(for: searchText)
                }
                
                switch picsViewModel.fetchState {
                case .idle:
                    Text("Search for Pics!").font(.largeTitle)
                case .isFetching:
                    ProgressView("Fetch FlickrPics....")
                        .controlSize(.extraLarge)
                case .fetched:
                    // Search Results
                    ScrollView {
                            
                        ForEach(picsViewModel.images, id: \.link) { image in
                            
                            NavigationLink(destination: FPDetailsView(image: image)) {
                                LazyVStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        AsyncImage(url: URL(string: image.media.m)) { obj in
                                            if let image = obj.image {
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                            } else {
                                                Color.gray
                                            }
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(image.title)
                                            Text(image.author)
                                            Text(image.published)
                                        }
                                    }
                                    
                                    Divider()
                                }
                            }
                            .padding(.bottom, 10)
                        }
                        .padding()
                    }
                case .fetchFailed(let errorDesc):
                    Text(errorDesc).font(.largeTitle)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
