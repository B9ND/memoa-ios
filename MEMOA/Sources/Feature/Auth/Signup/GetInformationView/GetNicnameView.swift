import SwiftUI

struct GetNicnameView: View {
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetSchoolViewboolean = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.darkmaincolor, Color.maincolor]),
                               startPoint: .top, endPoint: .bottom)
                .overlay (
                    Image(icon: .cloud)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 1075)
                        .offset(y:300)
                )
                VStack {
                    Text("회원가입")
                        .foregroundColor(.white)
                        .font(.bold(30))
                        .padding(.top, 130)
                        .padding(.bottom, 46)
                    CustomTextField(text: $SignupMV.nickname, placeholder: "닉네임을 입력하세요")
                    Spacer()
                    Image("TermsOfUse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 274)
                        .padding(.bottom, 5)
                    LongButton(text: "다음", color: .buttoncolor) {
                        GetSchoolViewboolean.toggle()
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
            .navigationDestination(isPresented: $GetSchoolViewboolean) {
                GetSchoolView()
                    }
        }
    }
}

#Preview {
    GetNicnameView()
}
