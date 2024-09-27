import SwiftUI

//MARK: 프로필에 나타나는 리스트
struct MyUploadList: View {
    @StateObject var myprofilMV: MyProfileViewModel = .init()
    @State private var isRefreshing = false
    @State private var error = false
    
    var body: some View {
        ScrollView {
            if isRefreshing {
                ProgressView()
                    .padding()
            }
            
            VStack(alignment: .leading) {
                ForEach(0..<myprofilMV.image.count, id: \.self) { index in
                    if index % 3 == 0 {
                        HStack {
                            ForEach(index..<min(index + 3, myprofilMV.image.count), id: \.self) { innerIndex in
                                AsyncImage(url: URL(string: myprofilMV.image[innerIndex].imageurl)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 130)
                                            .clipped()
                                    } else {
                                        ProgressView()
                                            .frame(width: 120, height: 130)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    MyUploadList()
}
