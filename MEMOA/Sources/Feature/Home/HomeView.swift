import SwiftUI

struct HomeView: View {
    @StateObject var HomeVM = HomeViewModel()
    
    var body: some View {
        VStack {
            SelectitemView()
            Divider()
            ScrollView {
                VStack {
                    UploadComponentView()
                }
                Spacer()
            }
            .refreshable {
                
            }
        }
    }
}

#Preview {
    HomeView()
}
