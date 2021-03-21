//
//  NewsDetailCell.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import UIKit

class NewsDetailCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    func setupCell(withData data: NewsObject){
        titleLabel.text = data.title
        authorNameLabel.text = data.author
        dateLabel.text = Date().dateToString(dateString: data.date)
        contentLabel.text = data.content
        if let url = URL(string: data.image) {
            newsImageView.kf.setImage(with: url)
        }
    }
    
    static func registerTo(tableView: UITableView?){
        let nib = UINib(nibName: "NewsDetailCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "NewsDetailCell")
    }

    static func dequeueFrom(tableView: UITableView, indexPath: IndexPath) -> NewsDetailCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailCell", for: indexPath) as! NewsDetailCell
        return cell
    }
}
