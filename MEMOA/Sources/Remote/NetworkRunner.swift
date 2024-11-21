//
//  Api.swift
//  MEMOA
//
//  Created by dgsw30 on 10/31/24.
//

import Foundation
import Alamofire

//MARK: 추상화메서드

struct VoidResponse: Decodable {}

class NetworkRunner {
    static let shared = NetworkRunner()
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIEventLogger()
        let session = Session(configuration: configuration, eventMonitors: [apiLogger])
        return session
    }()
    
    func request<Parameters: Encodable, Response: Decodable>(
        _ path: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders? = nil,
        response: Response.Type = VoidResponse.self,
        isAuthorization: Bool = false,
        completionHandler: @escaping (Result<Response, Error>) -> Void
    ) {
        session.request (
            secretUrl + path,
            method: method,
            parameters: parameters,
            encoder: method == .get ? URLEncodedFormParameterEncoder.default : JSONParameterEncoder.default,
            headers: headers,
            interceptor: isAuthorization ? AuthInterceptor() : nil
        )
        .validate()
        .responseDecodable(of: response) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func request<Response: Decodable>(
        _ path: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        response: Response.Type = VoidResponse.self,
        isAuthorization: Bool = true,
        completionHandler: @escaping (Result<Response, Error>) -> Void
    ) {
        session.request (
            secretUrl + path,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: headers,
            interceptor: isAuthorization ? AuthInterceptor() : nil
        )
        .validate()
        .responseDecodable(of: response) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func upload<Response: Decodable>(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        to url: String,
        usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
        method: HTTPMethod = .post,
        header: HTTPHeaders? = nil,
        response: Response.Type,
        isAuthorization: Bool = true,
        fileManager: FileManager = .default,
        completionHandler: @escaping (Result<Response, Error>) -> Void
    ) {
        session.upload(
            multipartFormData: multipartFormData,
            to: secretUrl + url,
            method: method,
            headers: header,
            interceptor: isAuthorization ? AuthInterceptor() : nil,
            fileManager: fileManager
        )
        .validate()
        .responseDecodable(of: response) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func query<Parameters: Encodable>(
        _ path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        isAuthorization: Bool = false,
        completionHandler: @escaping (Result<Void, Error>) -> Void
    ) {
        session.request(
            secretUrl + path,
            method: method,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers,
            interceptor: isAuthorization ? AuthInterceptor() : nil
        )
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completionHandler(.success(()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
