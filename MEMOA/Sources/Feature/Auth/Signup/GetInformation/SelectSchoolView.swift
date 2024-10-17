import SwiftUI

struct SelectSchoolView: View {
    @StateObject var SchoolMV: SchoolModelView = .init()
    @Environment(\.dismiss) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.searchbutton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .padding(.leading, 11)
                TextField("소속학교를 검색하세요", text: $SchoolMV.request.school)
                    .foregroundColor(.black)
            }
            .frame(width: 324, height: 36)
            .background(.white)
            .cornerRadius(50)
            .shadow(radius: 2, y: 1)
            .padding(.top, 38)
            .padding(.bottom, 18)
            ForEach(SchoolMV.request.selectSchool, id: \.self) { school in
                Button(action: {
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
    }
}
#Preview {
    SelectSchoolView()
}
//                presentation.wrappedValue.dismiss()
