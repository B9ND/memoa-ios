import Foundation

struct ServerUrl {
    var baseUrl = "http://13.125.84.202"
    
    func getUrl(for endpoint: String) -> String {
        return baseUrl + endpoint
    }
    
    static let shared = ServerUrl()
    
    private init() {}
}
