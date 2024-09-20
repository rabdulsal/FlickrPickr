//
//  ContentView.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var picsViewModel = FPListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                
                ForEach(picsViewModel.images, id: \.link) { image in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(image.title)
                        Text(image.author)
                        Text(image.description)
                        Text(image.published)
                        Text(image.media.m)
                        
                        Divider()
                    }
                    .padding(.bottom, 10)
                }
            }
            .onAppear {
                picsViewModel.searchImages(for: "porcupine")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
