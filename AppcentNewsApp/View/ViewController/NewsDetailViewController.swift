//
//  NewsDetailViewController.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import UIKit
import RealmSwift


class NewsDetailViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!{
        didSet{
            continueButton.layer.borderWidth = 1
            continueButton.layer.borderColor = UIColor.black.cgColor
            continueButton.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            NewsDetailCell.registerTo(tableView: tableView)
        }
    }
    var newsDetail: NewsObject!
    var fromFavorited: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationButtonSetup()
    }
    
    func navigationButtonSetup() {
        let shareImage    = UIImage(named: "share")!
        let favoritedImage  = UIImage(named: "favorited")!
        let shareButton   = UIBarButtonItem(image: shareImage,  style: .plain, target: self, action: #selector(self.didTapShareButton(sender:)))
        let favoritedButton = UIBarButtonItem(image: favoritedImage,  style: .plain, target: self, action: #selector(self.didTapFavoritedButton(sender:)))
        if fromFavorited == true {
            navigationItem.rightBarButtonItems = [shareButton]
        } else {
            navigationItem.rightBarButtonItems = [favoritedButton, shareButton]
        }
    }
    
    @objc func didTapShareButton(sender: AnyObject){
        let message = "First Whatsapp Share & https://www.google.co.in"
        var queryCharSet = NSCharacterSet.urlQueryAllowed

        queryCharSet.remove(charactersIn: "+&")

        if let escapedString = message.addingPercentEncoding(withAllowedCharacters: queryCharSet) {
            if let whatsappURL = URL(string: "whatsapp://send?text=\(escapedString)") {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [: ], completionHandler: nil)
                } else {
                    self.showAlertView(withTitle: "Alert", andMessage: "please install WhatsApp")
                }
            }
        }
    }

    @objc func didTapFavoritedButton(sender: AnyObject){
        let store = StoreFavorited()
        store.descriptionText = self.newsDetail.descriptionText
        store.title = self.newsDetail.title
        store.author = self.newsDetail.author
        store.image = self.newsDetail.image
        store.date = self.newsDetail.date
        store.linkUrl = self.newsDetail.linkUrl
        store.content = self.newsDetail.content 

        if let realm = try? Realm() {
            try? realm.write {
                realm.add(store)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            if  let detailViewController: WebViewController = segue.destination as? WebViewController, let data = sender {
                detailViewController.webLink = data as? String
            }
        }
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showWebView", sender: self.newsDetail.linkUrl)
    }
    
}

// MARK: - UITableViewDataSource

extension NewsDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsDetailCell.dequeueFrom(tableView: tableView, indexPath: indexPath)
        cell.setupCell(withData: self.newsDetail)
        return cell
    }
}
