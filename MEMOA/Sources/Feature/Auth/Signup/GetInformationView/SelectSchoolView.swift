import SwiftUI

struct SelectSchoolView: View {
    @EnvironmentObject var schoolVM: SchoolViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("searchbutton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .padding(.leading, 11)
                
                TextField("소속학교를 검색하세요", text: $schoolVM.request.school)
                    .foregroundColor(.black)
                    .tint(.maincolor)
                    .onChange(of: schoolVM.request.school) { newValue in
                        schoolVM.resetSchoolList()
                        schoolVM.fetchSchoolList(searchQuery: newValue)
                    }
            }
            .frame(width: 324, height: 36)
            .background(.white)
            .cornerRadius(50)
            .shadow(radius: 1, y: 1)
            .padding(.top, 38)
            .padding(.bottom, 18)
            
            if schoolVM.isLoading {
                ProgressView("검색 중...")
            } else if schoolVM.request.school.isEmpty {
                Text("검색 결과가 없습니다.")
                    .foregroundColor(.gray)
            } else if let errorMessage = schoolVM.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ForEach(schoolVM.getSchool, id: \.self) { school in
                    Button {
                        schoolVM.schoolName = school.name
                        dismiss()
                    } label: {
                        Text(school.name)
                            .font(.light(16))
                            .foregroundColor(.black)
                            .padding(.leading, 17)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 47, alignment: .leading)
                    .border(.gray, width: 1)
                }
            }
            Spacer()
        }
    }
}


#Preview {
    SelectSchoolView()
}
