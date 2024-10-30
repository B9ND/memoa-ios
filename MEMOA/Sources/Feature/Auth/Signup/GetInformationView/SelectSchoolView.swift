import SwiftUI

struct SelectSchoolView: View {
    @StateObject var schoolMV: SchoolViewModel = .init()
    @Environment(\.dismiss) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.searchbutton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .padding(.leading, 11)
                
                TextField("소속학교를 검색하세요", text: $schoolMV.request.school)
                    .foregroundColor(.black)
                    .tint(.maincolor)
                    .onChange(of: schoolMV.request.school) { newValue in
                        Task {
                            await schoolMV.searchSchool(by: newValue)
                        }
                    }
            }
            .frame(width: 324, height: 36)
            .background(.white)
            .cornerRadius(50)
            .shadow(radius: 1, y: 1)
            .padding(.top, 38)
            .padding(.bottom, 18)
            
            ForEach(schoolMV.request.selectSchool, id: \.self) { school in
                Button(action: {
                    presentation()
                }, label: {
                    HStack {
                        Text(school.schoolname)
                            .foregroundColor(.black)
                            .font(.light(16))
                            .padding(.leading, 17)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 47)
                    .background(.white)
                    .border(Color.gray.opacity(0.2))
                })
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await schoolMV.fetchSchools()
            }
        }
    }
}

#Preview {
    SelectSchoolView()
}
