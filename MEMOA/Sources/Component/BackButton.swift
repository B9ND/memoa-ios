import SwiftUI

struct BackButton: View {
    let text: String
    let systemImageName: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            EmptyView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: systemImageName)
                            .foregroundColor(.black)
                        Text(text)
                            .foregroundColor(.black)
                            .font(.custom("Pretendard-Bold", size: 16))
                    }
                }
            }
        }
    }
}
