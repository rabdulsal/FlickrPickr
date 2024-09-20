//
//  ContentView.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    
    let service = NetworkingService()
    @State private var jsonStr = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(jsonStr)")
        }
        .task {
            do {
                let result = try await service.searchImages(for: "porcupine")
                switch result {
                case .success(let data):
                    let dataStr = String(data: data, encoding: .utf8)
                    jsonStr = dataStr ?? "No Data"
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
