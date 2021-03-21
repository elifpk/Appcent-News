//
//  NewsCell.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(withData data: ArticlesModel){
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        if let image = data.image {
            let url = URL(string: image)
            newsImageView.kf.setImage(with: url)
        }
    }
    
    static func registerTo(tableView: UITableView?){
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "NewsCell")
    }

    static func dequeueFrom(tableView: UITableView, indexPath: IndexPath) -> NewsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        return cell
    }
}
