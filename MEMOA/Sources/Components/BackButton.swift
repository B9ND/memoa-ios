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
                            .foregroundStyle(fontcolor)
                        Text(text)
                            .foregroundStyle(fontcolor)
                            .font(.bold(16))
                    }
                }
            }
        }
    }
}