//
//  RestAPI.swift
//  mfourExcercise
//
//  Created by Kateryna Vynogradna on 4/9/18.
//  Copyright © 2018 Kateryna Vynogradna. All rights reserved.
//

import Foundation

enum RestAPI {
    case gallerySearch(query: String)
    case galleryImageComments(id: String)
}

extension RestAPI {
    var headers: [String: String]? {
        return ["Authorization": "Client-ID \(MFour.clientId)"]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var method: Method {
        return .get
    }

    var path: String {
        switch self {
        case .gallerySearch(_):
            return "/gallery/search"
        case .galleryImageComments(let id):
            return "/gallery/\(id)/comments"
        }
    }
    
    var base: String {
        return "https://api.imgur.com/3"
    }
    
    var baseURL: URL { return URL(string: base)! }

    var parameters: [String: Any]? {
        switch self {
        case .gallerySearch(let query):
            return ["q": query]
        case .galleryImageComments(_):
            return [:]
        }
    }
}

extension RestAPI: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        headers?.forEach({ (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

