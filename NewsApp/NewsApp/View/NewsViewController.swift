//
//  ViewController.swift
//  NewsApp
//
//  Created by Monalisa on 19/05/23.
//

import UIKit

class NewsViewController: UIViewController {
    private let tableView = UITableView()
    
    private var newsViewModel: NewsViewModel!
    private var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationController
        navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor(red: 54/255, green: 154/255, blue: 181/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        ]
        
        //TableView Creation
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: view.topAnchor),
                   tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchNews()
    }

    private func fetchNews() {
        isLoadingData = true
        
        newsViewModel = NewsViewModel(newDataRequest: NewsNetworkRequest())
        
        newsViewModel.fetchNews { [weak self] error in
            
            self?.isLoadingData = false
            
            if let error = error {
                print("Error fetching news: \(error.localizedDescription)")
            }
            else
            {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func loadMoreNewsIfNeeded(for indexPath: IndexPath)
    {
        if newsViewModel.shouldLoadMoreNews(for: indexPath)
        {
            fetchNews()
        }
    }
    
}

//TableView Designing
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel?.newsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        let news = newsViewModel.newsArray[indexPath.row]
        cell.configure(with: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsViewModel.newsArray[indexPath.row]
        let newsDetailViewController = NewsDetailViewController(news: news)
        navigationController?.pushViewController(newsDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            loadMoreNewsIfNeeded(for: indexPath)
        }
}



