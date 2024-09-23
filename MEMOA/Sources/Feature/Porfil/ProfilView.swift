import SwiftUI

struct ProfilView: View {
    // TODO: 프로필 뷰
    @StateObject var MyprofilMV: ProfilViewModel = .init()
    @State private var modify = false
    @State private var follow = false
    @State private var changename = false
    
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
                                                    .padding(.top,-44)
                                            }
                                    }
                                    HStack {
                                        Text(MyprofilMV.request.name)
                                            .font(.medium(16))
                                    }
                                    .padding(.bottom,4)
                                    .padding(.leading,2)
                                    Text(MyprofilMV.request.email)
                                        .foregroundStyle(.black)
                                        .font(.regular(12))
                                        .padding(.bottom,14)
                                    
                                    
                                    Button {
                                        follow.toggle()
                                    } label: {
                                        Text(follow ? "팔로우 취소" : "팔로우")
                                            .font(.medium(14))
                                            .frame(width: 186, height: 30)
                                            .background(follow ?  Color.white : Color.maincolor)
                                            .cornerRadius(8)
                                            .foregroundStyle(follow ? Color.black : Color.white)
                                            .shadow(radius: 1)
                                        
                                    }
                                    Spacer()
                                    MyUploadList()
                                }
                            }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
    }
}

#Preview {
    ProfilView()
}



