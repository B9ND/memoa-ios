import SwiftUI
import PhotosUI

// MARK: 글쓰기뷰
struct WriteView: View {
    @StateObject var writeVM = WriteViewModel()
    @StateObject var imageVM = ImageViewModel()
    @StateObject var getPostVM = GetPostViewModel()
    @State private var showImagePicker = false
    @State private var clickedTags: [Bool]
    @State private var showingAlert = false
    @Environment(\.dismiss) private var dismiss
    
    init() {
        _clickedTags = State(initialValue: Array(repeating: false, count: WriteViewModel().tagsList.count))
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("제목을 입력하세요", text: $writeVM.title, axis: .vertical)
                    .font(.medium(16))
                    .padding(.leading, 11)
                    .frame(height: 50)
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
                    ForEach(0..<writeVM.tagsList.count, id: \.self) { index in
                        Button {
                            clickedTags[index].toggle()
                            if clickedTags[index] {
                                writeVM.tags.append(writeVM.tagsList[index])
                            } else {
                                if let tagIndex = writeVM.tags.firstIndex(of: writeVM.tagsList[index]) {
                                    writeVM.tags.remove(at: tagIndex)
                                }
                            }
                        } label: {
                            Text(writeVM.tagsList[index])
                                .frame(width: 44, height: 29)
                                .cornerRadius(8)
                                .font(.regular(14))
                                .foregroundColor(.black)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(clickedTags[index] ? Color.maincolor : Color.graycolor))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)
            
            ZStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        TextView(text: $writeVM.content.text)
                            .padding()
                            .frame(height: 510)
                            .padding(.leading, 13)
                            .tint(.maincolor)
                            .overlay {
                                HStack {
                                    VStack {
                                        if writeVM.content.text.string.isEmpty {
                                            Text("내용을 입력해주세요")
                                                .font(.medium(16))
                                                .foregroundStyle(.graycolor)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .padding(8)
                                    .padding(.horizontal, 12)
                                    Spacer()
                                }
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.graycolor, lineWidth: 1)
                                    .frame(width: 335)
                                    .frame(maxHeight: .infinity)
                                //MARK: 이미지
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Button {
                                            showImagePicker.toggle()
                                        } label: {
                                            Image(icon: .selectImage)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding()
                                                .padding(.trailing, 4)
                                        }
                                        .sheet(isPresented: $showImagePicker) {
                                            ImagePicker(image: $imageVM.image)
                                        }
                                        .onChange(of: imageVM.image) { newImage in
                                            guard newImage != nil else {
                                                showingAlert = true
                                                return
                                            }
                                            //MARK: url 받았을때만 insert image됨
                                            imageVM.getImageUrl { imageUrl in
                                                guard let imageUrl = imageUrl else {
                                                    showingAlert = true
                                                    return
                                                }
                                                writeVM.images.append(imageUrl)
                                                writeVM.postContent.append("✔\(imageUrl)✔")
                                                insertImage(imageUrl: imageUrl)
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    .padding(.horizontal)
                }
            }
            
            // 스위치 컴포넌트
            Switch(bool: $writeVM.isReleased)
                .padding(.bottom, 4)
                .padding(.horizontal, 28)
            
            BackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
            CompleteButton(action: {
                writeVM.post()
            }, bool: writeVM.disabled)
            .alert(isPresented: $writeVM.showAlert) {
                Alert(title: Text("업로드 성공"), message: Text("게시글이 성공적으로 업로드되었어요!"), dismissButton: .default(Text("확인")){
                    getPostVM.loadPost()
                    dismiss()
                })
            }
        }
        .onAppear(perform : UIApplication.shared.hideKeyboard)
    }
    func insertImage(imageUrl: String) {
        guard let image = imageVM.image else {
            print("이미지가 선택되지 않았습니다.")
            return
        }
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        
        let maxWidth: CGFloat = 250
        let maxHeight: CGFloat = 250
        
        let originalSize = image.size
        var newSize = originalSize
        
        if originalSize.width > maxWidth {
            let aspectRatio = originalSize.height / originalSize.width
            newSize.width = maxWidth
            newSize.height = maxWidth * aspectRatio
        }
        
        if newSize.height > maxHeight {
            let aspectRatio = newSize.width / newSize.height
            newSize.height = maxHeight
            newSize.width = maxHeight * aspectRatio
        }
        
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        let imageAttributedString = NSAttributedString(attachment: imageAttachment)
        let mutableAttributedText = NSMutableAttributedString(attributedString: writeVM.content.text)
        mutableAttributedText.append(NSAttributedString(string: "\n"))
        mutableAttributedText.append(imageAttributedString)
        mutableAttributedText.append(NSAttributedString(string: "\n"))
        
        mutableAttributedText.addAttributes([
            .font: UIFont(name: "Pretendard-Medium", size: 15)!
        ], range: NSMakeRange(0, mutableAttributedText.length))
        
        writeVM.content.text = mutableAttributedText
        let plainText = writeVM.content.text.string
        writeVM.postContent.append(plainText)
    }
}

#Preview {
    WriteView()
}
