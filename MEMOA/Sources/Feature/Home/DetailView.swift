//
//  DetailView.swift
//  MEMOA
//
//  Created by dgsw30 on 9/10/24.
//

import SwiftUI

struct DetailView: View {
    @State private var clickbookmark = false
    @State private var showingalert = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: ProfilView()) {
                    Image(icon: .mediumprofile)
                }
                    .padding(.leading, 4)
                VStack(alignment: .leading) {
                    HStack {
                        Text("김은찬")
                            .foregroundStyle(.black)
                            .font(.medium(16))
                        Circle()
                            .frame(width: 5,height: 4)
                            .tint(Color.init(uiColor: .systemGray3))
                        Text("2024년 8월 13일")
                            .font(.medium(14))
                            .foregroundColor(.timecolor)
                    }
                    .padding(.vertical, 1)
                    
                    Text("국어, 과학 필기 공유합니다!")
                        .foregroundColor(.timecolor)
                        .font(.light(16))
                }
                Spacer()
            }
            .padding()
            Divider()
            ScrollView {
                VStack {
                    Text("기권의 특징 : 기권, 복사평형, 온실효과 기권에는 대류권, 성층권, 중간권, 열권이 있습니다.복사평형은 어떤 물체가 흡수하는 복사에너지양과 방출하는 에너지 양이 같은 상태입니다.")
                        .font(.light(18))
                    HStack {
                        Image(.example)
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Text("기권의 특징 : 기권, 복사평형 이였습ㅣㄴ다")
                            .font(.light(14))
                            .padding(.leading,14)
                        Spacer()
                    }
                    .padding(.bottom,30)
                    VStack {
                        HStack {
                            ForEach(0..<5) {_ in
                                Text("#국어")
                                    .font(.regular(12))
                                    .foregroundStyle(Color.timecolor)
                            }
                            Spacer()
                        }
                        HStack {
                            Button {
                                showingalert.toggle()
                            } label: {
                                Image(.chat)
                                    .foregroundStyle(.timecolor)
                            }
                            .alert(isPresented: $showingalert, content: {
                                Alert(title: Text("곧 추가될 예정입니다.."))
                            })
                            BookmarkButton()
                            Spacer()
                        }
                    }
                    .padding(.leading,14)
                }
            }
            .padding()
            Spacer()
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
        }
    }
}
#Preview {
    DetailView()
}
