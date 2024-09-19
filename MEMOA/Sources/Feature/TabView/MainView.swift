import SwiftUI

struct MainView: View {
    @State private var selectedtab: TabViewType = .home
    @State private var isNavigatingToWriteView = false

    var body: some View {
        NavigationStack {
            ZStack {
                switch selectedtab {
                case .home:
                    HomeView()
                case .search:
                    SearchView()
                case .bookmark:
                    BookmarkView()
                case .profil:
                    MyProfilView()
                case .plus:
                    EmptyView()
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
    }
}

#Preview {
    MainView()
}

