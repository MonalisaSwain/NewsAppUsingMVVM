//
//  NewsNetworkRequest.swift
//  NewsApp
//
//  Created by Monalisa on 19/05/23.
//

import Foundation

enum NetworkError : Error {
    case invalidData
}

class NewsNetworkRequest {
    
    func fetchNews(page: Int, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=168c94e4ccb64d21951079beef91a53f")
        
        let session = URLSession.shared.dataTask(with: url!){ data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))
            } catch {
                completion(.failure(error))
            }
        }
        session.resume()
    }
}
