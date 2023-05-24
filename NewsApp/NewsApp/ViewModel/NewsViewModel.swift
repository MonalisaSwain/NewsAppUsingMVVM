//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Monalisa on 19/05/23.
//

import Foundation


class NewsViewModel
{
    private var newDataRequest: NewsNetworkRequest
    private var currentPage = 1
    private var totalNews = 0
    private var isLoadingData = false
    
    var newsArray: [News] = []
    
    init(newDataRequest: NewsNetworkRequest)
    {
        self.newDataRequest = newDataRequest
    }
    
    func fetchNews(completion: @escaping (Error?) -> Void)
    {
        guard !isLoadingData else { return }
        
        isLoadingData = true
        
        newDataRequest.fetchNews(page: currentPage) { result in
            
            self.isLoadingData = false
            
            switch result {
            case .success(let newsResponse):
                self.newsArray.append(contentsOf: newsResponse.articles)
                self.currentPage += 1
                self.totalNews = newsResponse.totalResults
                completion( nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func shouldLoadMoreNews(for indexPath: IndexPath) -> Bool {
            return indexPath.row == newsArray.count - 1 && newsArray.count < totalNews
        }
}
