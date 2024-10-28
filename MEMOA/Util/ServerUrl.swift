import Foundation

struct ServerUrl {
    var baseUrl = secretUrl
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    
    static let shared = ServerUrl()
    
    private init() {}
}
