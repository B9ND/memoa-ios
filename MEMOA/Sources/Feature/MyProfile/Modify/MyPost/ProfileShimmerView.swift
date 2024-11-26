import SwiftUI

struct ProfileShimmerView: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 37, height: 37)
                    .shimmer()
                
                    .padding(.leading, 24)
                VStack(alignment: .leading) {
                    HStack {
                        Text("김은찬생일")
                            .foregroundStyle(.black)
                            .font(.medium(14))
                            .shimmer()
                        Circle()
                            .frame(width: 5, height: 4)
                            .tint(Color(uiColor: .systemGray3))
                            .shimmer()
                        Text("2024-12-08")
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
            
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 3) {
                        ForEach(0..<2) { _ in
                            Rectangle()
                                .cornerRadius(8, corners: .allCorners)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 220,height: 240)
                                .padding(.leading, 10)
                                .shimmer()
                        }
                    }
                    .padding(.horizontal, 70)
                }
                .scrollIndicators(.hidden)
            }
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<3) { _ in
                            Text("#안녕하세요")
                                .font(.regular(12))
                                .foregroundStyle(Color.timecolor)
                                .shimmer()
                        }
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 40)
            Divider()
            Spacer()
        }
    }
}

#Preview {
    ProfileShimmerView()
}

