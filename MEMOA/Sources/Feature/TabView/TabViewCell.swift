import SwiftUI

struct TabViewCell: View {
    
    let type: TabViewType
    let isSelected: Bool
    
    
    init(type: TabViewType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            Image(isSelected ? type.selectedImage : type.image)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.bottom, paddingbottom)
            Text(type.text)
                .foregroundColor(isSelected ?  Color.maincolor : Color.black)
                .font(.regular(10))
                .padding(.bottom, textbottom)
        }
    }
    
    private var paddingbottom : CGFloat {
        if type == .plus {
            return 8
        } else {
            return isSelected ? 5 : 3
        }
    }
    private var textbottom : CGFloat {
        if type == .plus {
            return 12
        } else {
            return isSelected ? 6 : 8
        }
    }
}
