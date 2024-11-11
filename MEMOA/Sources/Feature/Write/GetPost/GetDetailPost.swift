//
//  GetDetailPost.swift
//  MEMOA
//
//  Created by dgsw30 on 10/24/24.
//

import Foundation

//MARK: 게시글(detail)
struct GetDetailPost: Codable {
    let id: Int
    let title: String
    let content: String
    let author: String
    let authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    var getImageUrl: [URL] {
        images.compactMap { URL(string: $0) }
    }
}
