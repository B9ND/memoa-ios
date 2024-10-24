import SwiftUI
import UIKit

//MARK: 커스텀 textfield
struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if let mutableAttributedText = textView.attributedText.mutableCopy() as? NSMutableAttributedString {
                parent.text = mutableAttributedText
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.font = UIFont(name: "Pretendard-Medium", size: 15)
        textView.attributedText = text
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}
