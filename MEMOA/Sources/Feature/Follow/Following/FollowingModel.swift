//
//  FollowingModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/3/24.
//

import Foundation

struct FollowingModel: Codable {
    var email: String
    var nickname: String
    var description: String?
    var profileImage: String
    var department: FollowingDepartment
}

struct FollowingDepartment: Codable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}
