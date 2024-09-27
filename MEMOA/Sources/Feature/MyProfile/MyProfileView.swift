import SwiftUI

struct MyProfileView: View {
    //MARK: 프로필 뷰
    @StateObject var MyprofilMV: MyProfileViewModel = .init()
    @State private var modify = false
    @State private var follow = false
    @State private var changeName = false
    
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
                                                Image(icon: .bigprofile)
                                                    .padding(.top, -44)
                                                //                                                AsyncImage(url: url?) { image in
                                                //                                                    서버에서 이미지 받아올때 이미지
                                                //                                                } placeholder: {
                                                //                                                    progressview()
                                                //                                                }
                                                
                                            }
                                    }
                                    HStack {
                                        Text(MyprofilMV.name)
                                            .font(.medium(16))
                                        Button {
                                            changeName = true
                                        } label: {
                                            Image(icon: .pencil)
                                        }
                                    }
                                    .padding(.bottom, 4)
                                    
                                    .padding(.leading, 20)
                                    Text(MyprofilMV.email)
                                        .foregroundStyle(.black)
                                        .font(.regular(12))
                                        .padding(.bottom, 14)
                                    
                                    
                                    Button {
                                        print("MY")
                                    } label: {
                                        Text("MY")
                                            .font(.medium(14))
                                            .foregroundStyle(.black)
                                            .frame(width: 186, height: 30)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.graycolor, lineWidth: 1)
                                            }
                                    }
                                    Spacer()
                                    MyUploadList()
                                }
                            }
                    }
                    .navigationDestination(isPresented: $changeName) {
                        ChangeNameView()
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
                    modify = true
                } label: {
                    Image(icon: .setting)
                }
            }
        }
    }
}


#Preview {
    MyProfileView()
}


