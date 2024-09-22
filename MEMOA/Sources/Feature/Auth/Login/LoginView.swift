import SwiftUI

struct LoginView: View {
    @StateObject var LoginMV: LoginModelView = .init()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.darkmaincolor, Color.maincolor]),
                               startPoint: .top, endPoint: .bottom)
                .overlay (
                    Image("cloud")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 1075)
                        .offset(y:300)
                )
                VStack {
                    Text("로그인")
                        .foregroundColor(.white)
                        .font(.bold(30))
                        .padding(.top, 130)
                        .padding(.bottom, 46)
                    CustomTextField(text: $LoginMV.request.email, placeholder: "이메일을 입력하세요")
                        .padding(.bottom, 2)
                    HStack {
                        Image(.textfieldBook)
                            .padding(.leading, 11)
                        if LoginMV.request.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $LoginMV.request.password)
                                .foregroundColor(.black)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $LoginMV.request.password)
                                .foregroundColor(.black)
                                        }
                        Button(action: {
                            LoginMV.request.isSecure.toggle()})
                        {
                            Image(LoginMV.request.isSecure ? "openeye" : "closeeye")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 11)
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                    LongButton(text: "로그인", color: .buttoncolor) {
                        print("sldfkjsdf")
                    }
                    .padding(.bottom, 60)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("뒤로가기")
                        .foregroundColor(.white)
                        .font(.bold(16))
                }
                }
            }
    }
}

#Preview {
    LoginView()
}
