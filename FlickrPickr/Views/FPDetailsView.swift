//
//  FPDetailsView.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/20/24.
//

import SwiftUI

struct FPDetailsView: View {
    var image: FlickrPicItem
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.media.m)) { obj in
                if let image = obj.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Color.gray
                }
            }
            .frame(maxHeight: 300)
            
            Text(image.title)
                .font(.headline)
                .padding(.top)
            
            Text(image.description)
                .font(.body)
                .padding(.vertical)
            
            Text("Author: \(image.author)")
                .font(.subheadline)
                .padding(.bottom)
            
            Text("Published: \(DateFormatter.formattedPublishDate(image.published))")
                .font(.subheadline)
                .padding(.bottom)
        }
        .padding()
        .navigationTitle("Details")
    }
}

//#Preview {
//    FPDetailsView()
//}
