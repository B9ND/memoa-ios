import SwiftUI
struct GradeSelectButton: View {
    let grade: Int
    @Binding var selectedGrade: Int
    
    var body: some View {
        Button(action: {
            selectedGrade = grade
        }, label: {
            Text("\(grade)학년")
                .foregroundColor(.black)
                .font(.bold(20))
                .frame(width: 82, height: 78)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedGrade == grade ? Color.buttoncolor : Color.clear, lineWidth: 5)
                )
        })
    }
}

