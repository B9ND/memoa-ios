import SwiftUI

//MARK: 도담코드 보고 수정
struct MainView: View {
    @EnvironmentObject private var myProfileVM: MyProfileViewModel
    @State private var selectedtab: TabViewType = .home
    @State private var isNavigatingToWriteView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch selectedtab {
                case .home: HomeView()
                case .search: SearchView()
                case .bookmark: BookmarkView()
                case .profil: MyProfileView()
                case .plus: EmptyView()
                }
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        TabViewdesign()
                            .frame(width: geometry.size.width, height: 97)
                            .overlay(
                                HStack {
                                    ForEach(TabViewType.allCases, id: \.self) { tab in
                                        Button(action: {
                                            if tab == .plus {
                                                isNavigatingToWriteView = true
                                            } else {
                                                selectedtab = tab
                                            }
                                        }) {
                                            TabViewCell(type: tab, isSelected: selectedtab == tab)
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                }
                                    .padding(.horizontal, 20)
                            )
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .navigationDestination(isPresented: $isNavigatingToWriteView) {
                WriteView()
            }
        }
        .onAppear {
            myProfileVM.fetchMy()
        }
    }
}

#Preview {
    MainView()
}

