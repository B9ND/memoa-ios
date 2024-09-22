import SwiftUI


struct FirstView: View {
    
    @State private var loginboolean = false
    @State private var signupboolean = false
    
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
                    HStack {
                        VStack(alignment: .leading) {
                            Text("우리 학교 필기 공유")
                                .foregroundStyle(.white)
                                .font(.semibold(18))
                            Text("MEMOA")
                                .foregroundStyle(.white)
                                .font(.bold(36))
                        }
                        .padding(.top, 100)
                        Spacer()
                    }
                    .padding(.leading, 40)
                    Image("computer")
                        .padding(.top, 70)
                    Spacer()
                    LongButton(text: "로그인", color: .buttoncolor) {
                        loginboolean.toggle()
                    }
                    LongButton(text: "회원가입", color: .white) {
                        signupboolean.toggle()
                    }
                    .padding(.bottom, 60)
                }
                .navigationDestination(isPresented: $loginboolean) {
                    LoginView()
                        }
                .navigationDestination(isPresented: $signupboolean) {
                    GetEmailView()
                        }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        
    }
    
    #Preview {
        FirstView()
    }
