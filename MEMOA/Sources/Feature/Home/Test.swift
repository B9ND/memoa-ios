import SwiftUI

struct ContentView: View {
    let colors = ["Red", "Green", "Blue"]
    @State private var selectedColor = "Red"
    
    var body: some View {
        VStack {
            Picker("Select a color", selection: $selectedColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            Text("You selected: (selectedColor)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
