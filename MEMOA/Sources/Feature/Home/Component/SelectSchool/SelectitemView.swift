import SwiftUI

struct SelectitemView: View {
    @EnvironmentObject private var myProfileVM: MyProfileViewModel
    @ObservedObject var postVM: GetPostViewModel
    @StateObject var selectVM = SelectSchoolViewModel()
    var body: some View {
        HStack {
            // 내 학교
            if let myInformation = myProfileVM.profile {
                HStack {
                    Text(myInformation.department.school)
                        .font(.regular(14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                }
                .frame(width: 204)
                .frame(minHeight: 29)
                .background(Color.picker)
                .cornerRadius(8)
                
                //과목선택
                Menu {
                    ForEach(myInformation.department.subjects.indices, id: \.self) { index in
                        let subject = myInformation.department.subjects[index]
                        Button(action: {
                            if selectVM.selectedSubject != subject {
                                selectVM.selectedSubject = subject
                                postVM.page = 0
                                postVM.canLoadMore = true
                                postVM.posts.removeAll()
                                postVM.tags.removeAll()
                                postVM.tags.append(subject)
                                postVM.loadPost()
                            }
                            if selectVM.selectedSubject == "과목" {
                                postVM.page = 0
                                postVM.canLoadMore = true
                                postVM.posts.removeAll()
                                postVM.tags.removeAll()
                                postVM.tags.append(myInformation.department.school)
                                postVM.loadPost()
                            }
                        }) {
                            HStack {
                                Text(subject)
                                    .foregroundColor(selectVM.selectedSubject == subject ? .white : .black)
                                    .padding()
                                    .cornerRadius(5)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectVM.selectedSubject.isEmpty ? "과목" : selectVM.selectedSubject)
                            .font(.regular(14))
                            .foregroundColor(.black)
                        Image(.pickerItem)
                            .resizable()
                            .frame(width: 10, height: 9)
                    }
                    .frame(width: 59)
                    .frame(minHeight: 29)
                    .background(Color.picker)
                    .cornerRadius(8)
                }
                
                // 학년 선택 Menu
                Menu {
                    ForEach(selectVM.grade, id: \.grade) { gradeItem in
                        Button(action: {
                            if selectVM.selectedGrade != gradeItem.grade {
                                selectVM.selectedGrade = gradeItem.grade
                                postVM.page = 0
                                postVM.canLoadMore = true
                                postVM.posts.removeAll()
                                postVM.tags.removeAll()
                                postVM.tags.append(String("\(gradeItem.grade)학년"))
                                postVM.loadPost()
                            }
                        }) {
                            HStack {
                                Text("\(gradeItem.grade)학년")
                                    .foregroundColor(selectVM.selectedGrade == gradeItem.grade ? .white : .black)
                                    .padding()
                                    .cornerRadius(5)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectVM.selectedGrade == 0 ? "\(myInformation.department.grade)학년" : "\(selectVM.selectedGrade)학년")
                            .font(.regular(14))
                            .foregroundColor(.black)
                        Image(.pickerItem)
                            .resizable()
                            .frame(width: 10, height: 9)
                    }
                    .frame(width: 59)
                    .frame(minHeight: 29)
                    .background(Color.picker)
                    .cornerRadius(8)
                }
            }
        }
    }
}
