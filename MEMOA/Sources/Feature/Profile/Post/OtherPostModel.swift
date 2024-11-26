//
//  ostModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/14/24.
//

import Foundation

struct OtherPostModel: Decodable, HasImage {
    let id: Int
    let title, content, author, authorProfileImage: String
    let tags: [String]
    let createdAt: String
    let images: [String]
    let isBookmarked: Bool
}
