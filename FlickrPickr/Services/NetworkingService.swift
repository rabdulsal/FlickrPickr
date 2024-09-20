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
