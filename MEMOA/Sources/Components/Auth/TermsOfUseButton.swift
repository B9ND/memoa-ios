import SwiftUI
struct TermsOfUseButton: View {
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(icon: .termsofuse)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 274)
                .padding(.bottom, 5)
        })
    }
}
