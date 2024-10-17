import Foundation
import Alamofire

let serverUrl = ServerUrl.shared

class RefreshAccessToken {
    static let shared = RefreshAccessToken()
        
        private init() {}
    
    func reissue(complation: @escaping () -> Void) {
        let url = serverUrl.getUrl(for: "/auth/reissue")
        
        guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else {
            print("Refresh token이 존재하지 않습니다.")
            return
        }
        
        let parameter: [String: Any] = [
            "refreshToken": refreshToken
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: BaseResponse<TokenData>.self) { response in
            switch response.result {
            case .success(let result):
                UserDefaults.standard.set(result.data.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(result.data.refreshToken, forKey: "refreshToken")
                complation()
            case .failure(let error):
                print("토큰 발급 실패: \(error.localizedDescription)")
                if let httpResponse = response.response {
                    print("응답 코드: \(httpResponse.statusCode)")
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("서버 응답: \(errorMessage)")
                    }
                }
            }
        }

    }
}
