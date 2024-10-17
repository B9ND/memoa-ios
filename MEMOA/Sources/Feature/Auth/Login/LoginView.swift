import SwiftUI

struct LoginView: View {
    @StateObject var LoginMV: LoginModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var isLoginSuccess = false
    
    var body: some View {
        ZStack {
            AuthBackground()
            VStack {
                AuthText(text: "로그인")
                CustomTextField(text: $LoginMV.request.email, placeholder: "이메일을 입력하세요")
                    .padding(.bottom, 2)
                HStack {
                    Image(icon: .textfiledimage)
                        .padding(.leading, 11)
                    if LoginMV.isSecure {
                        SecureField("비밀번호를 입력하세요", text: $LoginMV.password)
                            .foregroundColor(.black)
                    } else {
                        TextField("비밀번호를 입력하세요", text: $LoginMV.password)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        LoginMV.isSecure.toggle()})
                    {
                        Image(icon: LoginMV.isSecure ? .closeeye : .openeye)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 11)
                }
                .frame(width: 304, height: 46)
                .background(.white)
                .cornerRadius(8)
                Spacer()
                LongButton(text: "로그인", color: .buttoncolor) {
                    Task {
                        let result = await LoginMV.login()
                        if result {
                            isLoginSuccess = true
                        } else {
                            print(LoginMV.loginerrorMessage ?? "로그인 실패")
                        }
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isLoginSuccess) {
            MainView()
        }
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
    }
}

#Preview {
    LoginView()
}
