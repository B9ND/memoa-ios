//
//  Iconography.swift
//  MEMOA
//
//  Created by dgsw30 on 9/23/24.
//

import Foundation
import SwiftUI

enum Iconography: String {
    // auth
    case openeyes = "openeye"
    case closeeyes = "closeeyes"
    case schoolbutton = "schoolbutton"
    case cloud = "cloud"
    case computer = "computer"
    case termsofuse = "termofuse"
    case textfiledimage = "TextfieldBook"
    // home
    case bookMark = "bm"
    case chating = "chat"
    case clickbookmark = "Clickbm"
    // 프로필
    case mediumProfile = "DetailProfilimage"
    case smallprofile = "homeprofil"
    case bigProfile = "Profilimage"
    case largeprofile = "55sizeProfile"
    
    // 학교선택
    case pickshcool = "PickerItem"
    //설정
    case setting = "setting"
    case pencil = "Pencil"
    // 검색
    case search = "searchbutton"
    case loading = "loading"
    // 글쓰기
    case selectImage = "selectimage"
    
    case uploadChat = "chatpost"
    
}

extension Image {
    init(icon: Iconography) {
        self = Image(icon.rawValue)
    }
}

struct MyView: View {
    var body: some View {
        Image(icon: .bookMark)
    }
}
