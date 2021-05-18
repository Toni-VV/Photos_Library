//
//  NetworkService.swift
//  PhotosLibrary
//
//  Created by Антон on 18.05.2021.
//

import Foundation

class NetworkService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let params = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(params: params)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(request: request, completion: completion)
        task.resume()
        
        
    }
    
    private func prepareHeader() -> [String: String] {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 02MLJcZQtMYNVDhlxgHIiqZh5isJpLtC8R4AQPcEJ38"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        
        var parameters = [String : String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
        
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
            
        }
    }
    
   
}
