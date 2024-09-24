import SwiftUI

struct BackButton: View {
    let text: String
    let systemImageName: String
    let fontcolor: Color
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            EmptyView()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: systemImageName)
                            .foregroundColor(fontcolor)
                        Text(text)
                            .foregroundColor(fontcolor)
                            .font(.bold(16))
                    }
                }
            }
        }
    }
}
