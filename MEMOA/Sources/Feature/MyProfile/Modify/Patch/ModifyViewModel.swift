//
//  ModifyViewModel.swift
//  MEMOA
//
//  Created by dgsw30 on 11/6/24.
//

import Foundation
import UIKit

class ModifyViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageUrl: String = ""
    @Published var nickname: String = ""
    @Published var description: String = ""
    
    @Published var showAlert = false
    func getImageUrl() {
        guard let image else {
            print("이미지가 없습니다.")
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            print("이미지 데이터를 변환하는 데 실패했습니다.")
            return
        }
        
        NetworkRunner.shared.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")}, to: "/image/upload", response: ImageResponse.self, isAuthorization: true) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.imageUrl = data.url
                    }
                case .failure(let error):
                    dump(error)
                }
            }
    }
    
    func patchMy() {
        let parameter: [String: Any] = [
            "profileImage": imageUrl
        ]
        
        NetworkRunner.shared.request("/auth/me", method: .patch, parameters: parameter, response: MyProfileModel.self) { result in
            switch result {
            case .success(let data):
                self.nickname = data.nickname
                self.imageUrl = data.profileImage
                self.description = data.description ?? "설명이 없습니다."
                self.showAlert = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
