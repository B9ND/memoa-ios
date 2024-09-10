import SwiftUI

struct Imagecard: Identifiable, Hashable {
    var id: UUID = .init()
    var image: String
}

var imagecard: [Imagecard] = [
    .init(image: "example1"),
    .init(image: "example1"),
    .init(image: "example1"),
    .init(image: "example1"),
    .init(image: "example1")
]

struct UploadComponentView: View {
    @State private var navigationtodetailview = false
    @State private var clickbookmark = false
    @State private var showingalert = false
    var body: some View {
        NavigationView {
            Button {
                navigationtodetailview = true
            } label: {
                VStack {
                    HStack {
                        Image("exampleimage")
                            .padding(.leading, 24)
                        VStack(alignment: .leading) {
                            HStack {
                                Text("김은찬")
                                    .foregroundStyle(.black)
                                    .font(.custom("Pretendard-Medium", size: 14))
                                Text("2024년 8월 13일")
                                    .font(.custom("Pretendard-Medium", size: 12))
                                    .foregroundColor(.timecolor)
                            }
                            .padding(.vertical, 2)
                            
                            Text("국어, 과학 필기 공유합니다!")
                                .foregroundColor(.timecolor)
                                .font(.custom("Pretendard-Light", size: 13))
                        }
                        Spacer()
                    }
                    VStack {
                        ScrollView(.horizontal) {
                            HStack(spacing: 3) {
                                ForEach(imagecard) { image in
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
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundStyle(Color.timecolor)
                            }
                            Spacer()
                        }
                        HStack {
                            Button {
                                showingalert.toggle()
                            } label: {
                                Image(.chat)
                                Text("\(13)")
                                    .foregroundStyle(.timecolor)
                            }
                            .alert(isPresented: $showingalert, content: {
                                Alert(title: Text("곧 추가될 예정입니다.."))
                            })
                            Button {
                                clickbookmark.toggle()
                            } label: {
                                Image(clickbookmark ? .clickbm : .bm )
                                    .resizable()
                                    .frame(width: 13,height: 16)
                                Text("\(1)")
                                    .foregroundStyle(.timecolor)
                                
                            }
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
}

#Preview {
    UploadComponentView()
}
