import SwiftUI

struct SelectitemView: View {
    @StateObject var selectVM = SelectSchoolViewModel()
    var body: some View {
        HStack {
            // 학교 선택 Menu
            Menu {
                ForEach(selectVM.school, id: \.school) { schoolItem in
                    Button(action: {
                        selectVM.selectedSchool = schoolItem.school
                    }) {
                        HStack {
                            Text(schoolItem.school)
                                .foregroundColor(selectVM.selectedSchool == schoolItem.school ? .white : .black)
                                .padding()
                                .cornerRadius(5)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectVM.selectedSchool)
                        .font(.regular(14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                    Image(icon: .pickshcool)
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
                ForEach(selectVM.grade, id: \.grade) { gradeItem in
                    Button(action: {
                        selectVM.selectedGrade = gradeItem.grade
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
                    Text("\(selectVM.selectedGrade)학년")
                        .font(.regular(14))
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
