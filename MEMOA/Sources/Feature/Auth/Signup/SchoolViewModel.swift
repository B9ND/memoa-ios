//import Foundation
//import Alamofire
//
//class SchoolModelView: ObservableObject {
//    @Published var request: SchoolModel = .init()
//
//    func fetchSchools() async {
//        let url = serverUrl.getUrl(for: "/school/search")
//    
//        do {
//            let response = try await
//            AF.request(
//                url,
//                method: .get
//            )
//            .serializingDecodable([SchoolListResponse].self).value
//            
//            request.selectSchool = response.map { SchoolList(schoolname: $0.name) }
//        } catch {
//            print("에러 \(error)")
//        }
//    }
//
//    func searchSchool(by name: String) async {
//        let url = serverUrl.getUrl(for: "/school/search")
//        
//        do {
//            let response = try await
//            AF.request(
//                url,
//                method: .get
//            )
//            .serializingDecodable([SchoolListResponse].self).value
//            
//            request.selectSchool = response.map { SchoolList(schoolname: $0.name) }
//        } catch {
//            print("에러 \(error)")
//        }
//    }
//
//    func addSchool(school: SchoolPostRequest) async -> Bool {
//        let url = serverUrl.getUrl(for: "/school")
//
//        do {
//            let response = try await
//            AF.request(
//                url,
//                method: .post,
//                parameters: school,
//                encoder: JSONParameterEncoder.default
//            )
//            .serializingDecodable(SchoolListResponse.self).value
//            
//            print("Added school: \(response.name)")
//            return true
//        } catch {
//            print("에러 \(error)")
//            return false
//        }
//    }
//}
