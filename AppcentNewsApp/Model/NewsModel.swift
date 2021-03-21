//
//  NewsModel.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 18.03.2021.
//

import ObjectMapper

class NewsModel: Mappable {

    var totalPage : Int?
    var articles : [ArticlesModel]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.totalPage <- map["totalResults"]
        self.articles <- map["articles"]
    }
}


