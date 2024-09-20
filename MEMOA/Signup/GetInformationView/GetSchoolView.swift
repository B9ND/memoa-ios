import SwiftUI

struct GetSchoolView: View {
    @StateObject var SchoolMV: SchoolModelView = .init()
    @Environment(\.dismiss) var dismiss
    @State private var GetSchoolViewboolean = false
    @State private var ModalViewboolean = false
    
    // 각 학년 버튼의 선택 상태를 관리하는 변수
    @State private var selectedGrade: Int? = nil

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
                        .padding(.bottom, 25)
                    Text("학년을 선택해주세요")
                        .foregroundColor(.white)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .padding(.bottom, 15)
                    
                    HStack {
                        // 1학년 버튼
                        Button(action: {
                            // 버튼이 클릭되면 selectedGrade 변수에 1학년(1) 저장
                            selectedGrade = 1
                        }, label: {
                            Text("1학년")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 20))
                                .frame(width: 82, height: 78)
                                .background(.white)
                                .cornerRadius(10)
                                // selectedGrade가 1인 경우 테두리 추가
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedGrade == 1 ? Color.buttoncolor : Color.clear, lineWidth: 5)
                                )
                        })
                        
                        // 2학년 버튼
                        Button(action: {
                            // 버튼이 클릭되면 selectedGrade 변수에 2학년(2) 저장
                            selectedGrade = 2
                        }, label: {
                            Text("2학년")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 20))
                                .frame(width: 82, height: 78)
                                .background(.white)
                                .cornerRadius(10)
                                // selectedGrade가 2인 경우 테두리 추가
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedGrade == 2 ? Color.buttoncolor : Color.clear, lineWidth: 5)
                                )
                        })
                        .padding(.horizontal, 10)
                        
                        // 3학년 버튼
                        Button(action: {
                            // 버튼이 클릭되면 selectedGrade 변수에 3학년(3) 저장
                            selectedGrade = 3
                        }, label: {
                            Text("3학년")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 20))
                                .frame(width: 82, height: 78)
                                .background(.white)
                                .cornerRadius(10)
                                // selectedGrade가 3인 경우 테두리 추가
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedGrade == 3 ? Color.buttoncolor : Color.clear, lineWidth: 5)
                                )
                        })
                    }
                    .padding(.bottom, 23)
                    
                    Button(action: {
                        ModalViewboolean.toggle()
                    }, label: {
                        Image("schoolbutton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 304)
                    })
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
            .sheet(isPresented: $ModalViewboolean) {
                SelectSchoolView()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.85)])
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
            .navigationDestination(isPresented: $GetSchoolViewboolean) {
                GetSchoolView()
                    }
        }
    }
}

#Preview {
    GetSchoolView()
}
