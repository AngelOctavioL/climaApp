//
//  UserBaseEndpoint.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import Foundation

struct UserBaseEndpoint: EndpointProtocol {
    let scheme: String = "https"
    var host: String = "api.weatherapi.com"
    var queries: [URLQueryItem]?
    var path: String
    
    init(path: String, queries: [URLQueryItem]? = nil) {
        self.queries = queries
        self.path = "/v1" + path
    }
}
