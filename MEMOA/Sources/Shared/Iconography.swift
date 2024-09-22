//
//  Iconography.swift
//  MEMOA
//
//  Created by dgsw30 on 9/23/24.
//
// TODO: 추가해야함
import Foundation
import SwiftUI

enum Iconography: String {
    case bookmark = "Bookmark"
}

extension Image {
    init(icon: Iconography) {
        self = Image(icon.rawValue)
    }
}

struct MyView: View {
    var body: some View {
        Image(icon: .bookmark)
    }
}
