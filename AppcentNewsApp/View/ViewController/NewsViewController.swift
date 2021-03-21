//
//  NewsViewController.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import UIKit
import ObjectMapper

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            NewsCell.registerTo(tableView: tableView)
            EmptyCell.registerTo(tableView: tableView)
            self.tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    private var newsData : NewsModel?
    private var newsArticle: [ArticlesModel] = []
    private var page = 1
    private var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchData() {

        if page == 1 {
            ProgressView.present(animated: true)
        }

        APINetwork.makeRequest(target: .search(query: searchText, page: page, apiKey: "68e29d10d6f744cf83c98f9dab02a288"), success: { (JSON) in
            ProgressView.dismiss(animated: true)
            let data = Mapper<NewsModel>().map(JSONObject: JSON.dictionaryObject)
            self.newsData = data
            
            guard self.newsArticle.count < self.newsData?.totalPage ?? 0 else {
                return
            }

            if let newsArticle = data?.articles {
                self.newsArticle.append(contentsOf: newsArticle)
            }
            self.tableView.reloadData()
        }, statusCode: { (statusCode, statusMessage, requestForm) in
            self.showAlertView(withTitle: "Error", andMessage: statusMessage)
            ProgressView.dismiss(animated: true)
        }, failure: { (moyaError) in
            self.showAlertView(withTitle: "Error", andMessage: moyaError.errorDescription)
            ProgressView.dismiss(animated: true)
        })
    }
  
    private func cleanData() {
        page = 1
        newsArticle = []
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetail" {
            if  let detailViewController: NewsDetailViewController = segue.destination as? NewsDetailViewController, let data = sender {
                detailViewController.newsDetail = data as? NewsObject
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArticle.count > 0 ? newsArticle.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.newsArticle.count < 1 {
            let cell = EmptyCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
            cell.titleLabel.text = "Arama sonucu görmek için arama kısmına bişeyler yazın..."
            return cell
        } else {
            let cell = NewsCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
            cell.setupCell(withData: self.newsArticle[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsObject = NewsObject()
        newsObject.image = self.newsArticle[indexPath.row].image ?? ""
        newsObject.title = self.newsArticle[indexPath.row].title ?? ""
        newsObject.content = self.newsArticle[indexPath.row].content ?? ""
        newsObject.descriptionText = self.newsArticle[indexPath.row].description ?? ""
        newsObject.date = self.newsArticle[indexPath.row].date ?? ""
        newsObject.linkUrl = self.newsArticle[indexPath.row].linkUrl ?? ""
        newsObject.author = self.newsArticle[indexPath.row].author ?? ""
        self.performSegue(withIdentifier: "showNewsDetail", sender: newsObject)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (newsArticle.count) - 10 {
            self.page = page + 1
            fetchData()
        }
    }
}

// MARK: - UISearchBarDelegate

extension NewsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }

    @objc func search() {
        if searchText.count > 2 {
            page = 1
            newsArticle = []
            fetchData()
        } else {
            cleanData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cleanData()
    }
}
