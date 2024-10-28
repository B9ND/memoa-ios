import SwiftUI

struct LongButton: View {
    let text: String
    let color: Color
    let action: () -> Void
  
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.medium(18))
                .foregroundStyle(.black)
                .frame(width: 304, height: 55)
                .background(color)
                .cornerRadius(8)
        }
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 6, x: 0, y: 0)


    }
}
//import SwiftUI
//
//struct LongButton: View {
//    let text: String
//    let color: Color
//    let action: () -> Void
//  
//    var body: some View {
//        Button(action: action) {
//            Text(text)
//                .font(.system(size: 18, weight: .medium))
//                .foregroundColor(.black)
//                .frame(width: 304, height: 55)
//                .background(color)
//                .cornerRadius(8)
//        }
//        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2) // 그림자 설정
//    }
//}
