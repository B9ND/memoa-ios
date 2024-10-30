import SwiftUI

struct GetSchoolView: View {
    @StateObject var schoolMV = SchoolViewModel()
    @StateObject var signUpMV: SignUpViewModel = .init()
    @Environment(\.dismiss) var dismiss
    @State private var toSelectSchoolView = false
    @State private var isSignUpSuccess = false
    @State private var selectGrade: Int = 0
    
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
                        GradeSelectButton(grade: 1, selectedGrade: $selectGrade)
                        GradeSelectButton(grade: 2, selectedGrade: $selectGrade)
                            .padding(.horizontal, 10)
                        GradeSelectButton(grade: 3, selectedGrade: $selectGrade)
                    }
                    .padding(.bottom, 23)
                    
                    Button(action: {
                        toSelectSchoolView = true
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
                            let result = await signUpMV.signup()
                            if result {
                                isSignUpSuccess = true
                            } else {
                                print(signUpMV.signupErrorMessage ?? "회원가입 실패")
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .sheet(isPresented: $toSelectSchoolView) {
                SelectSchoolView()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.85)])
            }
            .edgesIgnoringSafeArea(.all)
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white) // 뒤로가기 버튼
        }
        .fullScreenCover(isPresented: $isSignUpSuccess) {
            MainView()
        }
    }
}

#Preview {
    GetSchoolView()
}
