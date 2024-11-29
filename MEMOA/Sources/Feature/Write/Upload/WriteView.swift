import SwiftUI
import PhotosUI

// MARK: 글쓰기뷰
struct WriteView: View {
    @EnvironmentObject var myProfileVM: MyProfileViewModel
    @StateObject var writeVM = WriteViewModel()
    @StateObject var imageVM = ImageViewModel()
    @StateObject var getPostVM = GetPostViewModel()
    @State private var showImagePicker = false
    @State private var clickedTags: [Bool]
    @State private var showingAlert = false
    @Environment(\.dismiss) private var dismiss
    
    init() {
        _clickedTags = State(initialValue: Array(repeating: false, count: 0))
    }
    
    var body: some View {
        ScrollView {
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
                        if let profile = myProfileVM.profile {
                            ForEach(profile.department.subjects.indices, id: \.self) { index in
                                let subject = profile.department.subjects[index]
                                Button {
                                    if index < clickedTags.count {
                                        clickedTags[index].toggle()
                                        if clickedTags[index] {
                                            writeVM.tags.append(subject)
                                        } else {
                                            if let tagIndex = writeVM.tags.firstIndex(of: subject) {
                                                writeVM.tags.remove(at: tagIndex)
                                            }
                                        }
                                    }
                                } label: {
                                    Text(subject)
                                        .frame(width: 44, height: 29)
                                        .cornerRadius(8)
                                        .font(.regular(14))
                                        .foregroundColor(.black)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(
                                                    index < clickedTags.count && clickedTags[index]
                                                    ? Color.maincolor
                                                    : Color.graycolor
                                                )
                                        )
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
                .scrollIndicators(.hidden)
                
                VStack {
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
                                    }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                ZStack {
                    HStack {
                        // 스위치 컴포넌트
                        Switch(bool: $writeVM.isReleased)
                            .padding(.bottom, 4)
                            .padding(.horizontal, 28)
                        //MARK: 이미지
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
                                writeVM.postContent.append("✔★\(imageUrl)✔")
                                writeVM.insertComment()
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform : UIApplication.shared.hideKeyboard)
        
        ScrollView(.horizontal) {
            HStack(spacing: 3) {
                ForEach(Array(writeVM.getImageUrl.enumerated()), id: \.element) { index, url in
                    ZStack {
                        AsyncImage(url: url) { image in
                            image
                                .image?.resizable()
                                .cornerRadius(8, corners: .allCorners)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 105,height: 115)
                                .padding(.leading, 10)
                        }
                        Button {
                            writeVM.images.remove(at: index)
                            writeVM.deleteComment(index: index)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.black)
                                .foregroundStyle(Color.bordercolor)
                        }
                        .offset(x: 50, y: -50)
                    }
                }
            }
        }
        .onAppear {
            if let profile = myProfileVM.profile {
                clickedTags = Array(repeating: false, count: profile.department.subjects.count)
                if let school = myProfileVM.profile {
                    writeVM.tags.append(school.department.school)
                    writeVM.tags.append(String("\(school.department.grade)학년"))
                }
            }
        }
        
        .addBackButton(text: "뒤로가기", systemImageName: "chevron.left", fontcolor: .black)
        .completeButton(isAlert: $writeVM.showAlert, Title: "업로드 성공", SubTitle: "게시글이 성공적으로 업로드되었어요!" , action: {
            writeVM.post()
        }, isComplete: writeVM.disabled)
    }
}

#Preview {
    WriteView()
}
