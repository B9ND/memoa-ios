import SwiftUI

struct GetpasswordView: View {
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetNicnameViewboolean = false
    
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
                        if SignupMV.isSecure {
                            SecureField("비밀번호를 입력하세요", text: $SignupMV.password)
                                .foregroundColor(.black)
                        } else {
                            TextField("비밀번호를 입력하세요", text: $SignupMV.password)
                                .foregroundColor(.black)
                                        }
                        Button(action: {
                            SignupMV.isSecure.toggle()})
                        {
                            Image(SignupMV.isSecure ? "openeye" : "closeeye")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 11)
                    }
                    .frame(width: 304, height: 46)
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                    Image("TermsOfUse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 274)
                        .padding(.bottom, 5)
                    LongButton(text: "다음", color: .buttoncolor) {
                        GetNicnameViewboolean.toggle()
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
            .navigationDestination(isPresented: $GetNicnameViewboolean) {
                GetNicnameView()
                    }
        }
    }
}

#Preview {
    GetpasswordView()
}
