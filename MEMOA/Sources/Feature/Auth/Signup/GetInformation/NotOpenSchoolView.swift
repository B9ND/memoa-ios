//import SwiftUI
//
//struct NotOpenSchoolView: View {
//    @StateObject var SchoolMV = SchoolModelView ()
//    @StateObject var SignupMV: SignupModelView = .init()
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                AuthBackground()
//                VStack {
//                    AuthText(text: "회원가입")
//                        .padding(.bottom, -21)
//                    Image(.notopen)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 223)
//
//                    Spacer()
//                    
//                    TermsOfUseButton()
//                    LongButton(text: "회원가입 후 기다리기", color: .buttoncolor) {
//                    }
//                    .padding(.bottom, 60)
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
//            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .white)
//        }
//    }
//}
//
//#Preview {
//    NotOpenSchoolView()
//}
