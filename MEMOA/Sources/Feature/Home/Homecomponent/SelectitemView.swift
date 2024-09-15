import SwiftUI

struct SelectitemView: View {
    @StateObject var HomeVM = HomeViewModel()
    var body: some View {
        HStack {
            // 학교 선택 Menu
            Menu {
                ForEach(HomeVM.request.school, id: \.school) { schoolItem in
                    Button(action: {
                        HomeVM.selectedSchool = schoolItem.school
                    }) {
                        HStack {
                            Text(schoolItem.school)
                                .foregroundColor(HomeVM.selectedSchool == schoolItem.school ? .white : .black)
                                .padding()
                                .cornerRadius(5)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(HomeVM.selectedSchool)
                        .font(.custom("Pretendard-Regular", size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                    Image(.pickerItem)
                        .resizable()
                        .frame(width: 10, height: 9)
                }
                .frame(width: 233)
                .frame(minHeight: 29)
                .background(Color.picker)
                .cornerRadius(8)
            }
            
            // 학년 선택 Menu
            Menu {
                ForEach(HomeVM.request.grade, id: \.grade) { gradeItem in
                    Button(action: {
                        HomeVM.selectedGrade = gradeItem.grade
                    }) {
                        HStack {
                            Text("\(gradeItem.grade)학년")
                                .foregroundColor(HomeVM.selectedGrade == gradeItem.grade ? .white : .black)
                                .padding()
                                .cornerRadius(5)
                        }
                    }
                }
            } label: {
                HStack {
                    Text("\(HomeVM.selectedGrade)학년")
                        .font(.custom("Pretendard-Regular", size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 2)
                    Image(.pickerItem)
                        .resizable()
                        .frame(width: 10, height: 9)
                }
                .frame(width: 82)
                .frame(minHeight: 29)
                .background(Color.picker)
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    SelectitemView()
}
