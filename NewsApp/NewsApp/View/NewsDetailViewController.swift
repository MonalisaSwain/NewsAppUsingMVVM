//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Monalisa on 19/05/23.
//

import UIKit

class NewsDetailViewController: UIViewController {
    private let news: News
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 54/255, green: 154/255, blue: 181/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 92/255, green: 12/255, blue: 12/255, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Navigation Controller
        navigationItem.title = "Details"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor(red: 54/255, green: 154/255, blue: 181/255, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        ]
        
        //View Setup
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(newsImageView)
        
        setupConstraints()
        configure(with: news)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: 200),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            authorLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    private func configure(with news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.author == nil ? " ": "- " + news.author!
        
        if let imageUrl = news.imageUrl, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }
        }
        else
        {
            newsImageView.image = UIImage(named: "News")
        }
    }
}
