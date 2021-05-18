//
//  NetworkDataFetcher.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchPhotos(searchTerm: String, completion: @escaping ([UnsplashPhoto]?) -> Void) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            }
            
            let searchResponse = self.decodeJson(type: SearchResponse.self, from: data)
            let photos = searchResponse?.results
            DispatchQueue.main.async {
                completion(photos)
            }
        }
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil}
        do {
            let result = try decoder.decode(type.self, from: data)
            return result
        } catch {
            print("Error 2: \(error.localizedDescription)")
            return nil
        }
    }
    
}
