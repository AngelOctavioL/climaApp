//
//  WeatherModel.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import Foundation

class WeatherModel {
    var weather: WeatherResponse?
    let requestHandler: RequestHandlerProtocol = RequestHandler()
    
    func getWeather(city: String, completionHandler: @escaping (Error?) -> Void) {
        requestHandler.get(buildEndpoint(city: city)) { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                self.weather = response
                completionHandler(nil)
            case .failure(let failure):
                completionHandler(failure)
            }
        }
    }

    func buildEndpoint(city: String) -> EndpointProtocol {
        let queries = [
            URLQueryItem(name: "key", value: ""),
            URLQueryItem(name: "q", value: city)
        ]
        return UserBaseEndpoint(path: "/current.json", queries: queries)
    }
}
