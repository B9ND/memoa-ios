//
//  AuthInterceptor.swift
//  MEMOA
//
//  Created by dgsw30 on 10/31/24.
//

import Alamofire
import Foundation

//MARK: 토큰 재발급 인터셉터

class AuthInterceptor: RequestInterceptor {
    private var isTokenBeingRefreshed = false
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = UserDefaults.standard.string(forKey: "access") {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            print("저장")
        } else {
            print("엑세스 저장 x")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard response.statusCode == 401 || response.statusCode == 402 || response.statusCode == 404,
              let refreshToken = UserDefaults.standard.string(forKey: "refresh") else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        NetworkRunner.shared.request(
            "/auth/reissue",
            method: .post,
            parameters: RefreshToken(refresh: refreshToken),
            response: TokenResponse.self
        ) { result in
            self.isTokenBeingRefreshed = false
            switch result {
            case .success(let response):
                UserDefaults.standard.setValue(response.accessToken, forKey: "access")
                UserDefaults.standard.setValue(response.refreshToken, forKey: "refresh")
                completion(.retry)
            case .failure(let error):
                UserDefaults.standard.removeObject(forKey: "access")
                UserDefaults.standard.removeObject(forKey: "refresh")
                print(error.localizedDescription)
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
