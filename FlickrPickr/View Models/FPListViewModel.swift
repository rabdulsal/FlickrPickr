//
//  FPListViewModel.swift
//  FlickrPickr
//
//  Created by Rashad Abdul-Salam on 9/20/24.
//

import Foundation

enum DataFetchState {
    case idle, isFetching, fetched, fetchFailed(_ errorDesc: String)
}

@MainActor
class FPListViewModel: ObservableObject {
    
    @Published var images = [FlickrPicItem]()
    @Published var fetchState: DataFetchState = .idle
    let networkService = NetworkingService<FlickrPicData>()
    
    func searchImages(for searchString: String) {
        guard !searchString.isEmpty else {
            fetchState = .idle
            images = []
            return
        }
        
        Task {
            do {
                let result = try await networkService.searchImages(for: searchString)
                switch result {
                case .success(let picData):
                    fetchState = .fetched
                    images = picData.items
                case .failure(let error):
                    fetchState = .fetchFailed(error.localizedDescription)
                }
            } catch {
                fetchState = .fetchFailed(error.localizedDescription)
            }
        }
    }
    
}
