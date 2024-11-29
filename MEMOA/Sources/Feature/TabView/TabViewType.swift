import SwiftUI

enum TabViewType: CaseIterable {
    case home
    case search
    case plus
    case bookmark
    case profile
    
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
        case .profile:
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
        case .profile:
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
        case .profile:
            "프로필"
        }
    }
}
