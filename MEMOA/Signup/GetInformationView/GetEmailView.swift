import SwiftUI

struct GetEmailView: View {
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetpasswordViewboolean = false
    
    var body: some View {
        NavigationStack {
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
                    Text("회원가입")
                        .foregroundColor(.white)
                        .font(.custom("Pretendard-Bold", size: 30))
                        .padding(.top, 130)
                        .padding(.bottom, 46)
                    HStack {
                        Image(.textfieldBook)
                            .padding(.leading, 11)
                        TextField("이메일을 입력하세요", text: $SignupMV.email)
                            .foregroundColor(.black)
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("인증")
                                .foregroundStyle(.maincolor)
                                .font(.custom("Pretendard-Medium", size: 16))
                                .padding(.horizontal, 11)
                        })
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 2)
                    CustomTextField(text: $SignupMV.code, placeholder: "인증번호 6자리를 입력하세요")
                    Spacer()
                    Image("TermsOfUse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 274)
                        .padding(.bottom, 5)
                    LongButton(text: "다음", color: .buttoncolor) {
                        GetpasswordViewboolean.toggle()
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
                            .font(.custom("Pretendard-Bold", size: 16))
                    }
                }
            }
            .navigationDestination(isPresented: $GetpasswordViewboolean) {
                GetpasswordView()
                    }
        }
    }
}

#Preview {
    GetEmailView()
}
