//
//  RequestHandlerError.swift
//  ClimaApp
//
//  Created by Diplomado on 03/08/24.
//

import Foundation

enum RequestHandlerError: Error, LocalizedError {
    case badResponse(Int, String)
    case badRequest
    case emptyData
    case unexpectedResponse
    
    var errorDescription: String? {
        switch self {
        case .badRequest: return "Could not build request from provided URL"
        case let .badResponse(status, message): return "\(message) Code: \(status)"
        default: return ""
        }
    }
}
