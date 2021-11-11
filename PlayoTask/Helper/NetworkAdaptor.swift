//
//  NetworkAdaptor.swift
//  PlayoTask
//
//  Created by pampana ajay on 11/11/21.
//

import Foundation
import Alamofire

class NetworkAdaptor {
    static func request(url: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, urlParameters: [String: String]? = nil, bodyParameters: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> (Void))) {
        
        var urlParamsString = ""
        if let urlParams = urlParameters {
            urlParamsString = urlParamsString + "?"
            for (key, value) in urlParams {
                urlParamsString = urlParamsString + key + "=" + value + "&"
            }
            urlParamsString.removeLast()
        }
        
        let urlString = url + urlParamsString
        
        guard let urlConvertible = URL(string: urlString) else {
            completionHandler(nil, nil, nil)
            return
        }
        
        AF.request(urlConvertible, method: method, parameters: bodyParameters, encoding: encoding, headers: headers).responseJSON { response in
            if let error = response.error {
                completionHandler(nil, response.response, error)
            }else if let data = response.data {
                completionHandler(data, response.response, nil)
            }
        }
    }
    
    static func requestWithJson(url: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, urlParameters: [String: String]? = nil, bodyParameters: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping ((Any?, URLResponse?, Error?) -> (Void))) {
        
        var urlParamsString = ""
        if let urlParams = urlParameters {
            urlParamsString = urlParamsString + "?"
            for (key, value) in urlParams {
                urlParamsString = urlParamsString + key + "=" + value + "&"
            }
            urlParamsString.removeLast()
        }
        
        let urlString = url + urlParamsString
        
        guard let urlConvertible = URL(string: urlString) else {
            completionHandler(nil, nil, nil)
            return
        }
        
        AF.request(urlConvertible, method: method, parameters: bodyParameters, encoding: encoding, headers: headers).responseJSON { response in
            if let error = response.error {
                completionHandler(nil, response.response, error)
            }else if let value = response.value {
                completionHandler(value, response.response, nil)
            }
        }
    }
    
    static func requestWithModel<T: Codable>(url: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, urlParameters: [String: String]? = nil, bodyParameters: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, decodableModel: T.Type, completionHandler: @escaping ((T?, Error?) -> (Void))) {
        
        var urlParamsString = ""
        if let urlParams = urlParameters {
            urlParamsString = urlParamsString + "?"
            for (key, value) in urlParams {
                urlParamsString = urlParamsString + key + "=" + value + "&"
            }
            urlParamsString.removeLast()
        }
        
        let urlString = url + urlParamsString
        
        guard let urlConvertible = URL(string: urlString) else {
            completionHandler(nil, nil)
            return
        }
        
        AF.request(urlConvertible, method: method, parameters: bodyParameters, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in
            completionHandler(response.value, response.error)
        }
    }
}


