//
//  FavoritesViewController.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import UIKit
import RealmSwift
import Kingfisher
import ObjectMapper


class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            NewsCell.registerTo(tableView: tableView)
            EmptyCell.registerTo(tableView: tableView)
            self.tableView.tableFooterView = UIView()
        }
    }
    private var store: Results<StoreFavorited>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNewsFavorited()
    }
    
    func getNewsFavorited() {
        guard let realm = try? Realm() else {
            return
        }
        let data = realm.objects(StoreFavorited.self)
        self.store = data
        self.tableView.reloadData()
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewsDetail" {
            if  let detailViewController: NewsDetailViewController = segue.destination as? NewsDetailViewController, let data = sender {
                detailViewController.newsDetail = data as? NewsObject
                detailViewController.fromFavorited = true
            }
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if store == nil || store.count < 1 {
            return 1
        } else {
            return store.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if store.count < 1  {
            let cell = EmptyCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
            cell.titleLabel.text = "Favoriniz bulunmamaktadır."
            return cell
        } else {
            let cell = NewsCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
            if let url = URL(string: store[indexPath.row].image) {
                cell.newsImageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = store[indexPath.row].title
            cell.descriptionLabel.text = store[indexPath.row].descriptionText
            return cell
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsObject = NewsObject()
        newsObject.image = self.store[indexPath.row].image
        newsObject.title = self.store[indexPath.row].title
        newsObject.content = self.store[indexPath.row].content
        newsObject.descriptionText = self.store[indexPath.row].description
        newsObject.date = self.store[indexPath.row].date
        newsObject.linkUrl = self.store[indexPath.row].linkUrl
        newsObject.author = self.store[indexPath.row].author
        self.performSegue(withIdentifier: "showNewsDetail", sender: newsObject)
    }
}

extension Results {
    func toArray() -> [ArticlesModel] {
      return compactMap {
        $0 as? ArticlesModel
      }
    }
 }
