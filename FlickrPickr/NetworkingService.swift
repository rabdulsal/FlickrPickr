//
//  NetworkingService.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case failedResponse
}

struct FlickrPicData: Codable {
    let items: [FlickrPicItem]
}

struct FlickrPicItem: Codable {
    let link: String // Use for \.self in View display
    let title: String
    // TODO: Use CodingKey for media: "m" -> link
    let author: String
    let description: String // TODO: Will need to decode HTML to properly parse description
    let published: String
//    let height: String TODO: Will need to parse these from description
//    let width: String
}

enum DataFetchState {
    case isFetching, fetched, fetchFailed
}

@MainActor
class FPListViewModel: ObservableObject {
    
    @Published var images = [FlickrPicItem]()
    @Published var fetchState: DataFetchState = .isFetching
    let networkService = NetworkingService<FlickrPicData>()
    
    func searchImages(for searchString: String) {
        Task {
            do {
                let result = try await networkService.searchImages(for: "porcupine")
                switch result {
                case .success(let picData):
                    images = picData.items
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}


struct NetworkingService<T: Codable> {
    
    func searchImages(for searchString: String) async throws -> Result<T,Error> {
            
            let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchString)"
            
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }
            
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                throw NetworkError.failedResponse
            }
            let flickrPicData = try JSONDecoder().decode(T.self, from: data)
            return .success(flickrPicData)
        } catch {
            
            throw error
        }
    }
    
    
}
