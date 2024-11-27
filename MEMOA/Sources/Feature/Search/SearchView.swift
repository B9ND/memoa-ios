import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    @ObservedObject private var getPostVM = GetPostViewModel()
    @EnvironmentObject var myProfileVM: MyProfileViewModel

    @State private var toDetail = false
    @State private var selectedGrade = "1학년"
    @State private var selectedSubjects: Set<String> = []
    @State private var selectedSchool = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    searchVM.resetSearch()
                    searchVM.fetchPosts()
                }) {
                    Image(icon: .search)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                }

                TextField("검색어를 입력하세요", text: $searchVM.searchItem)
                    .font(.system(size: 16, weight: .medium))
                    .frame(height: 60)
                    .tint(.maincolor)
                    .focused($isSearchFocused)
            }
            .frame(height: 36)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .padding(.top, 8)

            HStack(spacing: 8) {
                Button(action: {
                    selectedSchool = selectedSchool.isEmpty ? (myProfileVM.profile?.department.school ?? "") : ""
                }) {
                    Text(selectedSchool.isEmpty ? (myProfileVM.profile?.department.school ?? "학교 선택") : selectedSchool)
                        .font(.system(size: 14))
                        .padding(.horizontal, 34)
                        .padding(.vertical, 8)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedSchool.isEmpty ? Color.gray.opacity(0.5) : .maincolor, lineWidth: 1)
                        )
                }
                .padding(.bottom, 6)

                Menu {
                    ForEach(["1학년", "2학년", "3학년"], id: \.self) { grade in
                        Button(action: {
                            selectedGrade = grade
                        }) {
                            Text(grade)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedGrade)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        Image("PickerItem")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color.purple.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.bottom, 6)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(myProfileVM.profile?.department.subjects ?? [], id: \.self) { subject in
                        Button {
                            if searchVM.selectedTags.contains(subject) {
                                searchVM.selectedTags.removeAll { $0 == subject }
                            } else {
                                searchVM.selectedTags.append(subject)
                            }
                        } label: {
                            Text(subject)
                                .frame(width: 44, height: 29)
                                .cornerRadius(8)
                                .font(.regular(14))
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(searchVM.selectedTags.contains(subject) ? .maincolor : Color.gray.opacity(0.5), lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal, 27)
                .padding(.vertical, 4)
                .padding(.bottom, 10)
            }

            GetSearchPost(searchVM: searchVM)
        }
        .onAppear {
            isSearchFocused = false
            selectedSchool = myProfileVM.profile?.department.school ?? ""
            selectedGrade = "\(myProfileVM.profile?.department.grade ?? 1)학년"
        }
        .onDisappear {
            searchVM.noPost = false
        }
        .navigationDestination(isPresented: $toDetail) {
            if let detailPost = getPostVM.detailPosts.first {
                DetailView(getPost: detailPost)
            }
        }
        .padding(.bottom, 63)
    }
}
