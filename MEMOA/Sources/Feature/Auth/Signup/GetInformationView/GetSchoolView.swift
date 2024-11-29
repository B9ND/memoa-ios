import SwiftUI

struct GetSchoolView: View {
    @StateObject var schoolVM = SchoolViewModel()
    @ObservedObject var signUpVM: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State private var toLogin = false
    @State private var toSelectSchoolView = false
    @State private var selectGrade = 0
    @State private var selectedDepartment: Department? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var departmentIDs: [String: Int] = [:]
    
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
                    .padding(.bottom, 20)
                    .onChange(of: selectGrade) { newGrade in
                        schoolVM.updateDepartments(for: newGrade)
                    }
                    
                    Button(action: { toSelectSchoolView = true }) {
                        HStack {
                            Image(icon: .textfiledimage)
                                .padding(.leading, 11)
                            Text(schoolVM.schoolName.isEmpty ? "소속학교를 선택하세요" : schoolVM.schoolName)
                                .foregroundColor(.black)
                                .font(.medium(16))
                        }
                        .frame(width: 304, height: 46, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .onChange(of: schoolVM.schoolName) { _ in
                        schoolVM.updateDepartments(for: selectGrade)
                    }
                    
                    Menu {
                        ForEach(schoolVM.selectedSchoolDepartments, id: \.self) { department in
                            Button(department.name) {
                                selectedDepartment = department
                                departmentIDs[department.name] = department.id
                            }
                        }
                    } label: {
                        HStack {
                            Image(icon: .textfiledimage)
                                .padding(.leading, 11)
                            Text(selectedDepartment?.name ?? "학과를 선택하세요")
                                .foregroundColor(.black)
                                .font(.medium(16))
                            Spacer()
                        }
                        .frame(width: 304, height: 46, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    TermsOfUseButton()
                    LongButton(text: "회원가입", color: .buttoncolor) {
                        Task {
                            signUpVM.departmentId = selectedDepartment?.id
                            switch await signUpVM.signup() {
                            case .success(_):
                                showAlert = true
                                alertMessage = "회원가입이 완료되었습니다."
                                toLogin = true
                            case .failure(let error):
                                showAlert = true
                                alertMessage = error.localizedDescription
                            }
                        }
                    }
                    .disabled(selectedDepartment == nil || selectGrade == 0 || schoolVM.schoolName.isEmpty)
                    .padding(.bottom, 60)
                }
            }
            .sheet(isPresented: $toSelectSchoolView) {
                SelectSchoolView()
                    .environmentObject(schoolVM)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.85)])
            }
            .onAppear(perform: UIApplication.shared.hideKeyboard)
            .edgesIgnoringSafeArea(.all)
            .alert("회원가입", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $toLogin, destination: {
                LoginView()
            })
            .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
        }
    }
}
