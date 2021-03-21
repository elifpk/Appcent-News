//
//  ArticlesModel.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import ObjectMapper

class ArticlesModel: Mappable {

    var author : String?
    var image : String?
    var date: String?
    var description: String?
    var linkUrl: String?
    var content: String?
    var title: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.author <- map["author"]
        self.image <- map["urlToImage"]
        self.date <- map["publishedAt"]
        self.description <- map["description"]
        self.linkUrl <- map["url"]
        self.content <- map["content"]
        self.title <- map["title"]
    }
}
