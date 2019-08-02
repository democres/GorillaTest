//
//  Router.swift
//  GorillaTest
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Alamofire

enum API : Router {
    case getAllRecipes(parameters: [String: Any]?)
    case getRecipe(recipeId: Int)
    
    var query: APIQuery {
        switch(self) {
        case .getAllRecipes(let parameters):
            return APIQuery(httpMethod: .get, path: "", parameters: parameters)
        case .getRecipe(let recipeId):
            return APIQuery(httpMethod: .get, path: String(recipeId), parameters: nil)
        }
    }
    
}

struct APIQuery {
    
    var headers: [String: String]?
    var httpMethod: Alamofire.HTTPMethod
    var path: String
    var parameters: [String: Any]?
    
    var paremeterEncoding: Alamofire.ParameterEncoding = URLEncoding.default
    var cachePolicy: String = ""
    
    init(httpMethod: Alamofire.HTTPMethod, path: String) {
        self.httpMethod = httpMethod
        self.path = path
    }
    
    init(httpMethod: Alamofire.HTTPMethod, path: String, parameters: [String: Any]?) {
        self.httpMethod = httpMethod
        self.path = path
        self.parameters = parameters
    }
}

protocol Router: URLRequestConvertible {
    var query: APIQuery { get }
}

extension Router {
    
    //MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: "https://gl-endpoint.herokuapp.com/recipes")
        var urlRequest = URLRequest(url: url!.appendingPathComponent(query.path))
        urlRequest.httpMethod = query.httpMethod.rawValue
        let encoding = query.paremeterEncoding
        print ("\(query.httpMethod.rawValue) \(try encoding.encode(urlRequest, with: query.parameters))")
        return try encoding.encode(urlRequest, with: query.parameters)
    }
    
}
