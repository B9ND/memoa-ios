import SwiftUI

struct UploadComponentView: View {
    @StateObject private var homeVM = HomeViewModel()
    @State private var navigationtodetailview = false
    @State private var showingalert = false
    
    var body: some View {
        Button {
            navigationtodetailview = true
        } label: {
            VStack {
                HStack {
                    Image(.homeprofil)
                        .padding(.leading, 24)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("김은찬")
                                .foregroundStyle(.black)
                                .font(.medium(14))
                            Circle()
                                .frame(width: 5,height: 4)
                                .tint(Color.init(uiColor: .systemGray3))
                            Text("2024년 8월 13일")
                                .font(.medium(12))
                                .foregroundColor(.timecolor)
                        }
                        .padding(.vertical, 2)
                        
                        Text("국어, 과학 필기 공유합니다!")
                            .foregroundColor(.timecolor)
                            .font(.light(13))
                    }
                    Spacer()
                }
                VStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: 3) {
                            ForEach(homeVM.imagecard) { image in
                                Image(image.image)
                                    .resizable()
                                    .frame(width: 220,height: 240)
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
                .padding(.horizontal, 70)
                Divider()
                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigationtodetailview) {
            DetailView()
        }
    }
}

#Preview {
    UploadComponentView()
}
