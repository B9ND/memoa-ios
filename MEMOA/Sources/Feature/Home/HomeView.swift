import SwiftUI

struct HomeView: View {
    @ObservedObject var HomeVM = HomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                SelectitemView()
                    .padding(.vertical, 8) 
                Divider()
                UploadComponentView()
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
