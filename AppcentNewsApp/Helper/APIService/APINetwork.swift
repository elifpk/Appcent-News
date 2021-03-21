//
//  APINetwork.swift
//  AppcentNewsApp
//
//  Created by Elif Parlak Kurt on 16.03.2021.
//

import Foundation
import Moya
import SwiftyJSON

struct APINetwork {

    @discardableResult static public func makeRequest(
        target: AppAPIService,
        success successWithJSON: @escaping (JSON) -> Void,
        statusCode statusCodeWithDetail: @escaping (_ statusCode: Int, _ message: String, _ formErrors: [String: [String]]?) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) -> Cancellable {
        var pluginArray: [PluginType] = [NetworkLoggerPlugin()]
//        let accessTokenPlugin = AccessTokenPlugin(tokenClosure:
//            .shared.token ?? "")

//        pluginArray.append(accessTokenPlugin)

        let provider = MoyaProvider<AppAPIService>(plugins: pluginArray)

        return provider.request(target, completion: {  result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successWithJSON(json)
                } catch MoyaError.statusCode(let errorResponse) {
                    do {
                        let errorJSON = try JSON(response.mapJSON())
                        if let errorString = errorJSON["message"].string {
                            if let formErrors = errorJSON["errors"].dictionaryObject {
                                statusCodeWithDetail(errorResponse.statusCode, errorString, formErrors as? [String: [String]])
                            } else {
                                statusCodeWithDetail(errorResponse.statusCode, errorString, nil)
                            }
                        }
                    } catch {
                        statusCodeWithDetail(errorResponse.statusCode, errorResponse.description, nil)
                    }
                } catch MoyaError.jsonMapping(let response) {
                    let statusCode = response.statusCode
                    if let response: HTTPURLResponse = response.response{
                        print("responseStatusNetwork : \(response)")
                        statusCodeWithDetail(statusCode, "", nil)
                        return
                    }
                    statusCodeWithDetail(statusCode, "", nil)
                }  catch {
                    statusCodeWithDetail(0, "error", nil)

                } catch MoyaError.underlying(let nsError) {

                }

            case let .failure(error):
                failureCallback(error)
            }
        })
    }

}
