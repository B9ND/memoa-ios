import SwiftUI

struct LongButton: View {
    let text: String
    let color: Color
    let action: () -> Void
//    init(
//        _ text: String,
//        color: Color = .buttoncolor,
//        action: @escaping () -> Void
//    ) {
//        self.text = text
//        self.color = color
//        self.action = action
//    }
//    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundStyle(.black)
                .frame(width: 304, height: 55)
                .background(color)
                .cornerRadius(8)
        }
        .shadow(
            color: Color(.sRGBLinear, white: 0, opacity: 0.1),
            radius: 6, x: 0, y: 1
        )

    }
}

//#Preview {
//    VStack(spacing: 30) {
//        LongButton(text: "회원가입", color: .white) {
//            print("회원가입")
//        }
//        LongButton(text: "회원가입 후 기다리기", color: .buttoncolor) {
//            print("회원가입 후 기다리기")
//        }
//    }
//}
