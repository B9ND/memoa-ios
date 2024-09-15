import SwiftUI

struct ProfilView: View {
    // TODO: 프로필 뷰
    @StateObject var profilMV: ProfilViewmodel = .init()
    @State private var modify = false
    @State private var follow = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.maincolor
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(maxWidth:.infinity)
                            .frame(height: geometry.size.height * 0.95)
                            .cornerRadius(30, corners: .topLeft)
                            .cornerRadius(30, corners: .topRight)
                            .overlay {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 100, height: 100)
                                            .padding(.top, -44)
                                            .overlay {
                                                Image(.profilimage)
                                                    .padding(.top,-44)
//                                                AsyncImage(url: url?) { image in
//                                                    서버에서 이미지 받아올때 이미지
//                                                } placeholder: {
//                                                    progressview()
//                                                }

                                            }
                                    }
                                    HStack {
                                        Text(profilMV.request.name)
                                            .font(.custom("Pretendard-Medium", size: 16))
                                        Button {
                                            modify.toggle()
                                        } label: {
                                            Image(.pencil)
                                        }
                                    }
                                    .padding(.bottom,4)
                                    
                                    .padding(.leading,20)
                                    Text(profilMV.request.email)
                                        .foregroundStyle(.black)
                                        .font(.custom("Pretendard-Regular", size: 12))
                                        .padding(.bottom,14)
                                    
                                    
                                    Button {
                                        follow.toggle()
                                    } label: {
                                        Text(follow ? "팔로우 취소" : "팔로우")
                                            .font(.custom("Pretendard-Medium", size: 14))
                                            .frame(width: 186, height: 30)
                                            .background(follow ?  Color.white : Color.maincolor)
                                            .cornerRadius(8)
                                            .foregroundStyle(follow ? Color.black : Color.white)
                                            .shadow(radius: 1)
                                        
                                    }
                                    Spacer()
                                    UploadList()                        
                                }
                            }
                    }
                    .navigationDestination(isPresented: $modify) {
                        ModifyView()
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    modify.toggle()
                } label: {
                    Image(.setting)
                }
            }
        }
    }
}


#Preview {
    ProfilView()
}

