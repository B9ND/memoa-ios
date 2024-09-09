import SwiftUI
import MyFoundation
import PhotosUI

struct WriteView: View {
    @ObservedObject var writeVM = WriteViewModel()
    @State private var clickedTags: [Bool]
    @Environment(\.dismiss) var dismiss
    
    init() {
        _clickedTags = State(initialValue: Array(repeating: false, count: WriteViewModel().request.tags.count))
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("제목을 입력하세요", text: $writeVM.request.title)
                    .font(.custom("Pretendard-Medium", size: 16))
                    .padding(.leading, 11)
                    .frame(height: 60)
                    .tint(.maincolor)
            }
            .frame(width: 335, height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.graycolor, lineWidth: 1)
            )
            .padding(.vertical, 4)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<writeVM.request.tags.count, id: \.self) { tags in
                        Button {
                            clickedTags[tags].toggle()
                            writeVM.Tagselection.append(writeVM.request.tags[tags])
                        } label: {
                            Text(writeVM.request.tags[tags].getName())
                                .frame(width: 44, height: 29)
                                .cornerRadius(8)
                                .font(.custom("Pretendard-Regular", size: 14))
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(clickedTags[tags] ? Color.maincolor : Color.graycolor)
                                )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 4)
            }
            
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        TextView(text: $writeVM.contentItem.text)
                            .padding()
                            .frame(height: 510)
                            .padding(.leading, 13)
                            .tint(.maincolor)
                            .overlay {
                                HStack {
                                    VStack {
                                        if
                                            writeVM.contentItem.text.string.isEmpty {
                                            Text("내용을 입력해주세요")
                                                .font(.custom("Pretendard-Medium", size: 16))
                                                .foregroundStyle(.graycolor)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .padding(8)
                                    .padding(.horizontal,12)
                                    Spacer()
                                }
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.graycolor, lineWidth: 1)
                                    .frame(width: 335)
                                    .frame(maxHeight: .infinity)
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        PhotosPicker(selection: $writeVM.contentItem.selectedItem, matching: .images, photoLibrary: .shared()) {
                                            Image(.selectimage)
                                                .resizable()
                                                .frame(width: 30,height: 30)
                                        }
                                        .onChange(of: writeVM.contentItem.selectedItem) { newItem in
                                            Task {
                                                if let newItem = newItem, let data = try? await newItem.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                                                    insertImage(uiImage)
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .padding(.trailing,4)
                                }
                                Spacer()
                            }
                    }
                    .padding(.horizontal)
                }
            }
            
            HStack {
                Text("우리학교만 공개")
                    .font(.custom("Pretendard-Regular", size: 14))
                ZStack(alignment: writeVM.request.isReleased ? .leading : .trailing) {
                    Rectangle()
                        .frame(width: 34, height: 14)
                        .foregroundStyle(writeVM.request.isReleased ? Color.gray.opacity(0.2) : Color.purple.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.25)) {
                                writeVM.request.isReleased.toggle()
                            }
                        }
                    
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(writeVM.request.isReleased ? .white : Color.togglecolor)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                }
                Spacer()
            }
            .padding(.bottom, 4)
            .padding(.horizontal, 28)
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("뒤로가기")
                                .foregroundColor(.black)
                                .font(.custom("Pretendard-Bold", size: 16))
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print(writeVM.request.tags)
                    } label: {
                        Text("완료")
                            .font(.custom("Pretendard-Bold", size: 16))
                            .foregroundColor(.maincolor)
                            .padding(.trailing, 14)
                    }
                }
            }
        }
    }
    
    func insertImage(_ image: UIImage) {
        let mutableAttributedText = NSMutableAttributedString(attributedString: writeVM.contentItem.text)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        let imageAttributedString = NSAttributedString(attachment: imageAttachment)
        
        let selectedRange = NSMakeRange(mutableAttributedText.length, 0)
        
        mutableAttributedText.insert(imageAttributedString, at: selectedRange.location)
        
        mutableAttributedText.addAttributes([
            .font: UIFont(name: "Pretendard-Medium", size: 15)!
        ], range: NSMakeRange(0, mutableAttributedText.length))
        
        writeVM.contentItem.text = mutableAttributedText
    }
}

#Preview {
    WriteView()
}

