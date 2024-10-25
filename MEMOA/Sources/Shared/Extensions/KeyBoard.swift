import SwiftUI

// MARK: - View Extension
extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(KeyboardDismissModifier())
    }
}

// MARK: - Keyboard Dismiss Modifier
struct KeyboardDismissModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                dismissKeyboard()
            }
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

