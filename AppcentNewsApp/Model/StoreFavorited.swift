//
//  StoreFavorited.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import Foundation
import RealmSwift

class StoreFavorited: Object {
    
    @objc dynamic var author = ""
    @objc dynamic var image = ""
    @objc dynamic var date = ""
    @objc dynamic var descriptionText = ""
    @objc dynamic var linkUrl = ""
    @objc dynamic var content = ""
    @objc dynamic var title = ""
}
