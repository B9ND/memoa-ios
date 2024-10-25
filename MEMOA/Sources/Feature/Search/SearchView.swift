import SwiftUI
import UIKit

struct SearchView: View {
    @StateObject var searchVM = SearchViewModel()
    @ObservedObject var getPostVM = GetPostViewModel()
    @State private var toDetail = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    searchVM.getPost()
                    searchVM.addSearchItem()
                    searchVM.saveSearches()
                } label: {
                    Image(icon: .search)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding(.leading, 12)
                }
                TextField("검색어를 입력하세요", text: $searchVM.searchItem) {
                }
                .font(.medium(16))
                .frame(height: 60)
                .tint(.maincolor)
                .hideKeyboardOnTap()
            }
            .frame(width: 327, height: 36)
            .background(Color.init(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("최근검색어")
                        .font(.regular(12))
                        .foregroundStyle(.recently)
                    Spacer()
                    Button {
                        searchVM.clearSearches()
                        searchVM.saveSearches()
                    } label: {
                        Text("모두지우기")
                            .font(.regular(12))
                            .foregroundStyle(.recently)
                    }
                    .padding(.trailing, 30)
                }
                .padding(.leading, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(searchVM.recentSearchesList, id: \.self) { recentitem in
                            Text(recentitem.recentSearch)
                                .font(.regular(14))
                                .frame(width: 102, height: 29)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.graycolor, lineWidth: 1)
                                }
                        }
                    }
                    .padding()
                }
            }
            HStack {
                if searchVM.noLoading {
                    Text("태그를 재입력해주세요!")
                        .font(.regular(14))
                        .foregroundStyle(.recently)
                } else {
                    Text("태그로 검색해주세요")
                        .font(.regular(14))
                        .foregroundStyle(.recently)
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            GetSearchPost(searchVM: searchVM)
        }
        .padding(.bottom, 63)
        .onAppear {
            searchVM.loadSearches()
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
    }
}

#Preview {
    SearchView()
}
