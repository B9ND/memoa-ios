import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(.textfieldBook)
                .padding(.leading, 11)
            TextField(placeholder, text: $text)
                .foregroundColor(.black)
        }
        .frame(width: 304, height: 46)
        .background(.white)
        .cornerRadius(8)
    }
}
