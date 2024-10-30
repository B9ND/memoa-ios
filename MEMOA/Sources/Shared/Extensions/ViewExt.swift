//
//  ViewExt.swift
//  MEMOA
//
//  Created by dgsw30 on 9/11/24.
//

import SwiftUI

//TODO: 프로필 corneradius
public extension View {
    func cornerRadius(_ radius: CGFloat, corners: RoundedCornerShape.RectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

fds;lfkdsajf;ladskfj
