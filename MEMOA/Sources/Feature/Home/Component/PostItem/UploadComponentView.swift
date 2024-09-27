import SwiftUI

struct UploadComponentView: View {
    @State private var toDetail = false
    @State private var showingAlert = false
    @State private var toProfile = false
    var board: BoardModel
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
            toDetail = true
        } label: {
            VStack {
                HStack {
                    Button(action: {
                        toProfile.toggle()
                    }, label: {
                        Image(icon: .smallprofile)
                    })
                    .padding(.leading, 24)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(board.nickname)
                                .foregroundStyle(.black)
                                .font(.medium(14))
                            Circle()
                                .frame(width: 5, height: 4)
                                .tint(Color(uiColor: .systemGray3))
                            Text(board.time)
                                .font(.medium(12))
                                .foregroundColor(.timecolor)
                        }
                        .padding(.vertical, 2)
                        
                        Text(board.title)
                            .foregroundColor(.timecolor)
                            .font(.light(13))
                    }
                    Spacer()
                }
                
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 3) {
                            ForEach(board.image) { image in
                                Image(image.image)
                                    .resizable()
                                    .frame(width: 220, height: 240)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .scaleEffect(0.95)
                            }
                        }
                        .padding(.horizontal, 70)
                    }
                    .scrollIndicators(.hidden)
                }
                
                VStack {
                    HStack {
                        ForEach(board.tag.split(separator: ","), id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.regular(12))
                                .foregroundStyle(Color.timecolor)
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                            showingAlert = true
                        } label: {
                            Image(icon: .chating)
                                .foregroundStyle(.timecolor)
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("곧 추가될 예정입니다.."))
                        }
                        BookmarkButton()
                        Spacer()
                    }
                }
                .padding(.horizontal, 70)
                Divider()
                Spacer()
            }
        }
        .navigationDestination(isPresented: $toDetail) {
            DetailView(board: BoardModel(nickname: board.nickname, time: board.time, image: [Imagelist(image: "example")], title: board.title, tag: board.tag, email: board.email))
        }
        .navigationDestination(isPresented: $toProfile) {
            ProfileView(board: BoardModel(nickname: board.nickname, time: board.time, image: [Imagelist(image: "example")], title: board.title, tag: board.tag, email: board.email))
        }
    }
}
