import SwiftUI

struct GetSchoolView: View {
    @StateObject var SchoolMV: SchoolModelView = .init()
    @StateObject var SignupMV: SignupModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var ModalViewboolean = false
    @State private var isSignupSuccess = false
    
    // 각 학년 버튼의 선택 상태를 관리하는 변수
    //    @State private var selectedGrade: Int? = nil
    @State private var selectedGrade: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthBackground()
                VStack {
                    AuthText(text: "회원가입")
                        .padding(.bottom, -21)
                    Text("학년을 선택해주세요")
                        .foregroundColor(.white)
                        .font(.bold(16))
                        .padding(.bottom, 15)
                    
                    HStack {
                        // 1학년 버튼
                        GradeSelectButton(grade: 1, selectedGrade: $selectedGrade)
                        
                        // 2학년 버튼
                        GradeSelectButton(grade: 2, selectedGrade: $selectedGrade)
                            .padding(.horizontal, 10)
                        
                        // 3학년 버튼
                        GradeSelectButton(grade: 3, selectedGrade: $selectedGrade)
                    }
                    .padding(.bottom, 23)
                    
                    Button(action: {
                        ModalViewboolean = true
                    }, label: {
                        Image(icon: .schoolbutton)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 304)
                    })
                    Spacer()
                    TermsOfUseButton()
                    LongButton(text: "회원가입", color: .buttoncolor) {
                        Task {
                            let result = await SignupMV.signup() // 비동기 호출
                            if result {
                                isSignupSuccess = true
                            } else {
                                print(SignupMV.signupErrorMessage ?? "회원가입 실패") // 실패 시 에러 메시지 출력
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .sheet(isPresented: $ModalViewboolean) {
                SelectSchoolView()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.85)])
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
                .fullScreenCover(isPresented: $isSignupSuccess) {
                    MainView()
                }
        }
    }
}

#Preview {
    GetSchoolView()
}
