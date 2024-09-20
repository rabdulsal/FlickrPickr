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
        TextField("Search", text: $searchText, onEditingChanged: { _ in
            onSearchTextChanged()
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
}

struct ContentView: View {
    
    @StateObject private var picsViewModel = FPListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        
        
        ZStack {
            
            VStack {
                
                // SearchBar
                FPSearchBar(searchText: $searchText) {
                    picsViewModel.searchImages(for: searchText)
                }
                
                // Search Results
                ScrollView {
                        
                    ForEach(picsViewModel.images, id: \.link) { image in
                        
                        LazyVStack(alignment: .leading, spacing: 8) {
                            Text(image.title)
                            Text(image.author)
                            Text(image.description)
                            Text(image.published)
                            Text(image.media.m)
                            
                            Divider()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding()
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
