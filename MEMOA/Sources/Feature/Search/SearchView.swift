//
//  SearchView.swift
//  MEMOA
//
//  Created by dgsw30 on 8/24/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image(.searchPost)
                        .resizable()
                        .frame(width: 22,height: 22)
                        .padding(.leading,12)
                    TextField("검색어를 입력하세요", text: $searchVM.searchItem) {
                        searchVM.addSearchItem()
                        searchVM.saveSearches()
                    }
                    .font(.custom("Pretendard-Medium", size: 16))
                    .frame(height: 60)
                    .tint(.maincolor)
                }
                .frame(width: 327,height: 36)
                .background(Color.init(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding()
                HStack {
                    Text("최근검색어")
                        .font(.custom("Pretendard-Regular", size: 12))
                        .foregroundStyle(.recently)
                    Spacer()
                    Button {
                        searchVM.clearSearches()
                    } label: {
                        Text("모두지우기")
                            .font(.custom("Pretendard-Regular", size: 12))
                            .foregroundStyle(.recently)
                    }
                    .padding(.trailing,30)
                    
                }
                .padding(.leading,40)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(searchVM.recentSearcheslist
                                , id: \.self) { recentitem in
                            Text(recentitem.RecentSearch)
                                .font(.custom("Pretendard-Regular", size: 14))
                                .frame(width: 102,height: 29)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.graycolor, lineWidth: 1)
                                }
                        }
                    }
                    .padding()
                }
                VStack {
                    HStack {
                        Text("추천 글")
                            .font(.custom("Pretendard-Regular", size: 12))
                            .foregroundStyle(.recently)
                        Spacer()
                    }
                    .padding(.leading,40)
                    ScrollView {
                        ForEach(0..<5) { recommend in
                            UploadComponentView()
                        }
                    }
                    .refreshable {
                        
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            searchVM.loadSearches()
        }
        .frame(height: .infinity)
    }
}

#Preview {
    SearchView()
}
