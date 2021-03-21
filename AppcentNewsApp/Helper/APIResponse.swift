//
//  APIResponse.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 19.03.2021.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    var data: T?
    var code: Int
    var success: Bool
    var http_response: Int
}

func decode<T: Decodable>(data: Data, ofType: T.Type) -> T? {
    do {
        let decoder = JSONDecoder()
        let res = try decoder.decode(APIResponse<T>.self, from: data)
        return res.data
    } catch let parsingError {
        print("Error", parsingError)
    }
    return nil
}
