//
//  AppAPIService.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import Moya

enum AppAPIService {
    
    case search(query: String, page: Int, apiKey: String)
}

extension AppAPIService: TargetType {

    var path: String {
        switch self {
        case .search:
            return "everything"
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .search(let query, let page, let apiKey):
            return ["q": query, "page": page, "apiKey": apiKey]
        }
    }

    var method: Moya.Method {
        switch self {
            //        case .search:
            //            return .post
            //        case .search:
            //            return .put
            //        case .search:
        //            return .delete
        default:
            return .get
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    var headers: [String : String]? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        return self.method == .get ? URLEncoding.queryString : JSONEncoding.default
    }

    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }

    var sampleData: Data {
        let a = ""
        return a.data(using: .utf8)!
    }
}
