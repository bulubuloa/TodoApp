//
//  WebAPI.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import RxSwift
import Alamofire

enum WebAPIMethod {
    case get
    case post
}

enum WebAPIError: Error {
    case jsonError
    case unknow
    case notfound
}

protocol IWebAPI {
    func request<T: Codable>(method: WebAPIMethod, enpoint: String, requestModel: IWebAPIRequestModel?) -> Single<T>
}

class WebAPI: IWebAPI {
    func request<T: Codable>(method: WebAPIMethod, enpoint: String, requestModel: IWebAPIRequestModel?) -> Single<T>{
        var parameters: RequestModel?
        if let query = requestModel {
            parameters = try? query.getParameters()
        }

        switch method {
            case .get:
                return requestGet(endpoint: enpoint, query: parameters ?? [:])
            case .post:
                return requestPost(endpoint: enpoint, query: parameters ?? [:])
        }
    }
    
    private func requestGet<T: Codable>(endpoint: String, query: [String: Any] = [:]) -> Single<T> {
        let singleReturn = Single<T>.create {
            single in
            
            let request = AF.request(endpoint, parameters: query)
                .responseDecodable(of: T.self) {
                    response in
                    
                    guard let requestRespose = response.response else {
                        single(.failure(WebAPIError.unknow))
                        return
                    }
                    
                    switch requestRespose.statusCode {
                        case 200:
                            if let responseFinal = response.value {
                                single(.success(responseFinal))
                            } else {
                                single(.failure(WebAPIError.jsonError))
                            }
                        case 404:
                            single(.failure(WebAPIError.notfound))
                        default:
                            single(.failure(WebAPIError.unknow))
                    }
                }
                
            return Disposables.create() {
                request.cancel()
            }
        }
        return singleReturn
    }
    
    private func requestPost<T: Codable>(endpoint: String, query: [String: Any] = [:]) -> Single<T> {
        return Single<T>.create {
            single in

            let request = AF.request(endpoint, method: .post, parameters: query, encoding: JSONEncoding.default)
                .responseDecodable(of: T.self) {
                    response in
                    guard let requestRespose = response.response else {
                        single(.failure(WebAPIError.unknow))
                        return
                    }
                    
                    print("StatusCode => \(requestRespose.statusCode)")
                    switch requestRespose.statusCode {
                    case 200...201:
                            if let responseFinal = response.value {
                                single(.success(responseFinal))
                            } else {
                                single(.failure(WebAPIError.jsonError))
                            }
                        case 404:
                            single(.failure(WebAPIError.notfound))
                        default:
                            single(.failure(WebAPIError.unknow))
                    }
                }
            
            return Disposables.create() {
                request.cancel()
            }
        }
    }
}
