import SwiftUI

//MARK: 프로필 수정
struct ModifyView: View {
    @EnvironmentObject private var myProfileVM: MyProfileViewModel
    @StateObject private var modifyVM = ModifyViewModel()
    @State private var showAlert = false
    @Environment(\.openURL) private var openURL
    @State private var showImagePicker = false
    @State private var changeProfileImage = true
    @State private var changeName = false
    @State private var changeDescription = false
    @State private var changeSchool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.graycolor
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(maxWidth:.infinity)
                        .frame(height: geometry.size.height * 0.95)
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                        .overlay {
                            if let profile = myProfileVM.profile {
                                VStack {
                                    ZStack {
                                        //MARK: 그대로의 이미지
                                        if let url = URL(string: profile.profileImage) {
                                            AsyncImage(url: url) { image in
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 100, height: 100)
                                                    .padding(.top, -44)
                                                    .overlay {
                                                        image
                                                            .image?.resizable()
                                                            .cornerRadius(40, corners: [.allCorners])
                                                            .frame(width: 80, height: 80)
                                                            .padding(.top, -44)
                                                    }
                                            }
                                        }
                                        
                                        //MARK: 바뀔거
                                        if let url = URL(string: modifyVM.imageUrl) {
                                            AsyncImage(url: url) { image in
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 100, height: 100)
                                                    .padding(.top, -44)
                                                    .overlay {
                                                        image
                                                            .image?.resizable()
                                                            .cornerRadius(40, corners: [.allCorners])
                                                            .frame(width: 80, height: 80)
                                                            .padding(.top, -44)
                                                    }
                                            }
                                        }
                                        
                                        //MARK: 프로필 이미지 수정
                                        Button {
                                            showImagePicker = true
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.bordercolor)
                                                    .frame(width: 22, height: 22)
                                                    .overlay {
                                                        Circle()
                                                            .stroke(Color.fix, lineWidth: 1)
                                                    }
                                                Image(icon: .pencil)
                                            }
                                        }
                                        .padding(.trailing, 60)
                                        .sheet(isPresented: $showImagePicker) {
                                            ImagePicker(image: $modifyVM.image)
                                        }
                                        .onChange(of: modifyVM.image) { newImage in
                                            guard newImage != nil else {
                                                return
                                            }
                                            changeProfileImage = false
                                            modifyVM.getImageUrl()
                                        }
                                    }
                                    
                                    HStack {
                                        Text(profile.nickname)
                                            .font(.medium(16))
                                        Button {
                                            changeName = true
                                        } label: {
                                            Image(icon: .pencil)
                                        }
                                    }
                                    .padding(.bottom, 4)
                                    
                                    .padding(.leading, 20)
                                    Text(profile.email)
                                        .foregroundStyle(.black)
                                        .font(.regular(12))
                                        .padding(.bottom, 14)
                                    
                                    VStack {
                                        ModifyViewbutton(text: "이름 변경", action: {
                                            changeName = true
                                        }, color: .black)
                                        
                                        ModifyViewbutton(text: "자기소개 변경", action: {
                                            changeDescription = true
                                        }, color: .black)
                                        
                                        ModifyViewbutton(text: "소속 변경", action: {
                                            changeSchool = true
                                        }, color: .black)
                                        
                                        ModifyViewbutton(text: "개인 정보 이용 약관", action: {
                                            if let url = URL(string: "링크") {
                                                openURL(url)
                                            }
                                        }, color: .black)
                                        ModifyViewbutton(text: "로그아웃", action: {
                                            myProfileVM.delete()
                                            withAnimation {
                                                UserDefaults.standard.removeObject(forKey: "access")
                                            }
                                        }, color: .red)
                                        
                                        HStack {
                                            Spacer()
                                            Button {
                                                showAlert = true
                                            } label: {
                                                Text("회원탈퇴")
                                                    .underline()
                                                    .foregroundStyle(.red)
                                                    .font(.regular(12))
                                            }
                                            .alert(isPresented: $showAlert) {
                                                Alert(
                                                    title: Text("정말 회원탈퇴 하시겠습니까?"),
                                                    primaryButton: .default(Text("취소"))
                                                    {
                                                    },
                                                    secondaryButton: .destructive(Text("탈퇴")) {
                                                    }
                                                )
                                            }
                                        }
                                        .padding(.vertical, 14)
                                        .padding(.trailing, 23)
                                    }
                                    
                                    .padding()
                                    Spacer()
                                }
                            }
                        }
                }
                .navigationDestination(isPresented: $changeName) {
                    ChangeNameView(changeNameVM: modifyVM)
                }
                .navigationDestination(isPresented: $changeDescription) {
                    ChangeDesciptionView(changeDescriptionVM: modifyVM)
                }
                .navigationDestination(isPresented: $changeSchool) {
//                    ChangingDepartmentView()
                }
                .ignoresSafeArea()
            }
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
            CompleteButton(action: {
                modifyVM.patchMy()
            }, bool: changeProfileImage, Title: "이미지 수정성공!", SubTitle: nil, alertBool: $modifyVM.imageAlert)
        }
    }
}
