//
//  FollowerModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/2/24.
//

import Foundation

struct FollowerModel: Codable {
    var email: String
    var nickname: String
    var description: String?
    var profileImage: String
    var department: FollowerDepartment
}

struct FollowerDepartment: Codable {
    var name: String
    var grade: Int
    var school: String
    var subjects: [String]
}

