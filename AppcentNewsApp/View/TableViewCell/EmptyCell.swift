//
//  EmptyCell.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import UIKit

class EmptyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    static func registerTo(tableView: UITableView?){
        let nib = UINib(nibName: "EmptyCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "EmptyCell")
    }

    static func dequeueFrom(tableView: UITableView, indexPath: IndexPath) -> EmptyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
        return cell
    }
    
}
