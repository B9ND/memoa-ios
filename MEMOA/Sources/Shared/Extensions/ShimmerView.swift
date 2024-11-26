//
//  ShimmerView.swift
//  MEMOA
//
//  Created by dgsw30 on 11/25/24.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Circle()
                        .frame(width: 37 ,height: 37)
                        .shimmer()
                }
                .padding(.leading, 24)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("바인드")
                            .foregroundStyle(.black)
                            .font(.medium(14))
                            .shimmer()
                        Circle()
                            .frame(width: 5, height: 4)
                            .tint(Color(uiColor: .systemGray3))
                            .shimmer()
                        Text("2013-03-20")
                            .font(.medium(12))
                            .foregroundColor(.timecolor)
                            .shimmer()
                    }
                    .padding(.vertical, 2)
                    
                    Text("안녕하세요")
                        .foregroundColor(.timecolor)
                        .font(.light(13))
                        .shimmer()
                }
                Spacer()
            }
        }
        
        VStack {
            HStack(spacing: 3) {
                ForEach(0..<2) { _ in
                    Rectangle()
                        .frame(width: 200, height: 240)
                        .cornerRadius(8, corners: .allCorners)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 10)
                        .shimmer()
                }
            }
            .padding(.leading, 70)
        }
        
        VStack {
            HStack {
                ForEach(0..<5) { _ in
                    Text("#김은찬입니다.")
                        .font(.regular(12))
                        .foregroundStyle(Color.timecolor)
                        .shimmer()
                }
                Spacer()
            }
        }
        .padding(.horizontal, 40)
        Divider()
        Spacer()
    }
}

#Preview {
    ShimmerView()
}
