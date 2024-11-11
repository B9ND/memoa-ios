//
//  FollowingViewModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/3/24.
//

import Foundation

class FollowingViewModel: ObservableObject {
    @Published var followings: [FollowingModel] = []
    
    func getFollowing(user: String) {
        let parameters: [String: Any] = ["user": user]
        NetworkRunner.shared.request("/follow/followings", method: .get, parameters: parameters, response: [FollowingModel].self) { result in
            switch result {
            case .success(let data):
                self.followings = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
