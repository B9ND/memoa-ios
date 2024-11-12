//
//  FollowerViewModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import Foundation

class FollowerViewModel: ObservableObject {
    
    @Published var followers: [FollowerModel] = []
    
    func getFollower(nickname: String) {
        let parameters: [String: Any] = ["nickname": nickname]
        NetworkRunner.shared.request("/follow/followers", method: .get, parameters: parameters, response: [FollowerModel].self) { result in
            switch result {
            case .success(let data):
                self.followers = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
