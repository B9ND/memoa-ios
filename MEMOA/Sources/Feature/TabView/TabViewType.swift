import SwiftUI

enum TabViewType: CaseIterable {
    case home
    case search
    case plus
    case bookmark
    case profil
    
    var image: String {
        switch self {
        case.home:
            return "Home"
        case .search:
            return "Search"
        case .plus:
            return "Plus"
        case .bookmark:
            return "Bookmark"
        case .profil:
            return "Profil"
        }
    }
    
    var selectedImage: String {
           switch self {
           case .home:
               return "ClickHome"
           case .search:
               return "ClickSearch"
           case .plus:
               return "Plus"
           case .bookmark:
               return "ClickBookmark"
           case .profil:
               return "ClickProfil"
           }
       }
    var text: String {
        switch self {
        case .home:
            "메인"
        case .search:
            "검색"
        case .plus:
            "메모작성"
        case .bookmark:
            "북마크"
        case .profil:
            "프로필"
        }
    }
    
}
