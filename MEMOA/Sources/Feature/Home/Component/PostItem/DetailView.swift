////
////  DetailView.swift
////  MEMOA
////
////  Created by dgsw30 on 9/10/24.
////
//
//import SwiftUI
//
////MARK: 게시물 자세히
//struct DetailView: View {
//    @State private var showingAlert = false
//    @State private var toProfile = false
//    @Environment(\.dismiss) private var dismiss
//    var board: BoardModel
//    
//    var body: some View {
//        VStack {
//            HStack {
//                ProfileButton(action: {
//                    toProfile = true
//                }, image: "homeprofil")
//                    .padding(.leading, 4)
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text(board.nickname)
//                            .foregroundStyle(.black)
//                            .font(.medium(16))
//                        Circle()
//                            .frame(width: 5,height: 4)
//                            .tint(Color.init(uiColor: .systemGray3))
//                        Text(board.time)
//                            .font(.medium(14))
//                            .foregroundColor(.timecolor)
//                    }
//                    .padding(.vertical, 1)
//                    
//                    Text(board.title)
//                        .foregroundColor(.timecolor)
//                        .font(.light(16))
//                }
//                Spacer()
//            }
//            .padding()
//            Divider()
//            ScrollView {
//                VStack {
//                    Text("기권의 특징 : 기권, 복사평형, 온실효과 기권에는 대류권, 성층권, 중간권, 열권이 있습니다.복사평형은 어떤 물체가 흡수하는 복사에너지양과 방출하는 에너지 양이 같은 상태입니다.")
//                        .font(.light(18))
//                    HStack {
//                        Image(.example)
//                            .padding()
//                        Spacer()
//                    }
//                    HStack {
//                        Text("기권의 특징 : 기권, 복사평형 이였습ㅣㄴ다")
//                            .font(.light(14))
//                            .padding(.leading, 14)
//                        Spacer()
//                    }
//                    .padding(.bottom, 30)
//                    VStack {
//                        HStack {
//                            ForEach(board.tag.split(separator: ","), id: \.self) { tag in
//                                Text("#\(tag)")
//                                    .font(.regular(12))
//                                    .foregroundStyle(Color.timecolor)
//                            }
//                            Spacer()
//                        }
//                        HStack {
//                            ChatButton()
//                            BookmarkButton()
//                            Spacer()
//                        }
//                    }
//                    .padding(.leading, 14)
//                }
//            }
//            .padding()
//            Spacer()
//            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
//        }
//        .navigationDestination(isPresented: $toProfile) {
//            ProfileView(board: board)
//        }
//        //프로필은 다른 보드로 하면 좋을듯?
//    }
//}
