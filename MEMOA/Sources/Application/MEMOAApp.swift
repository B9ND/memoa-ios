//
//  MEMOAApp.swift
//  MEMOA
//
//  Created by dgsw30 on 8/19/24.
//

import SwiftUI

@main
struct MEMOAApp: App {
    @AppStorage("access") private var accessToken: String?
    @StateObject private var myProfileVM = MyProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if accessToken == nil {
                    FirstView()
                } else {
                    MainView()
                }
            }
            //MARK: 프록시 에러 제거
            .environmentObject(myProfileVM)
            .onChange(of: accessToken) { _ in
                Task {
                    try? await Task.sleep(for: .seconds(0.2))
                    NavigationUtil.popToRootView()
                }
            }
        }
    }
}
