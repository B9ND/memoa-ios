//
//  FollowerViewModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import Foundation

class FollowerViewModel: ObservableObject {
    
    @Published var followers: [FollowerModel] = []
    @Published var isFollowed = false
    
    func getFollower(nickname: String) {
        let parameters: [String: Any] = ["nickname": nickname]
        NetworkRunner.shared.request("/follow/followers", method: .get, parameters: parameters, response: [FollowerModel].self) { result in
            switch result {
            case .success(let data):
                self.followers = data
                self.isFollowed = data.first(where: { $0.nickname == nickname })?.isFollowed ?? false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func follow(nickname: String) {
        NetworkRunner.shared.query("/follow", method: .post, parameters: ["nickname" : nickname], isAuthorization: true) { result in
            switch result {
            case .success():
                self.isFollowed.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
