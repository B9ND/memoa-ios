import SwiftUI

// TODO: 프로필에 나타나는 리스트
struct UploadList: View {
    @ObservedObject var profilMV: ProfilViewModel = .init()
    @State private var isRefreshing = false
    @State private var error = false
    
    var body: some View {
        ScrollView {
            if isRefreshing {
                ProgressView()
                    .padding()
            }
            
            VStack(alignment: .leading) {
                    ForEach(0..<profilMV.request.image.count, id: \.self) {
                        index in
                    if index % 3 == 0 {
                        HStack {
                            ForEach(index..<min(index + 3, profilMV.request.image.count), id: \.self) { innerIndex in
                                AsyncImage(url: URL(string: profilMV.request.image[innerIndex].imageurl)) { phase in
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
    //        .refreshable {
    //            await refreshData()
    //        }
    //새로고침 기능
    
    //    func refreshData() async {
    //        isRefreshing = true
    //        try? await Task.sleep(nanoseconds: 2 * 2_000_000_000)
    //        profilMV.shuffleImages()
    //        isRefreshing = false
    //    }
    // 새로고침 함수
}

#Preview {
    UploadList()
}

