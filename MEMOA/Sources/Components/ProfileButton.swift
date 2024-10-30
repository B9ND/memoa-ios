//
//  ProfileButton.swift
//  MEMOA
//
//  Created by dgsw30 on 10/18/24.
//

import SwiftUI
//MARK: 프로필로 이동하는 버튼
struct ProfileButton: View {
    enum ProfileType {
        case home, detail
        
        var icon: Iconography {
            switch self {
            case .home:
                    .smallprofile
            case .detail:
                    .mediumProfile
            }
        }
    }
    
    let type: ProfileType
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(icon: type.icon)
        }
    }
}
