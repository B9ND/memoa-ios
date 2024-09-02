import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    var onImagesSelected: ([UIImage]) -> Void
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItems,
            matching: .images
        ) {
            Text("Select Images")
        }
        .onChange(of: selectedItems) { newItems in
            selectedImages = []
            
            Task {
                for newItem in newItems {
                    if let data = try? await newItem.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                        selectedImages.append(uiImage)
                    }
                }
                onImagesSelected(selectedImages)
            }
        }
    }
}

