//
//  MEMOAApp.swift
//  MEMOA
//
//  Created by dgsw30 on 8/19/24.
//

import SwiftUI

@main
struct MEMOAApp: App {
    @AppStorage("access")
    private var accessToken: String?
    @StateObject private var myProfileVM = MyProfileViewModel()
    var body: some Scene {
        WindowGroup {
            if accessToken == nil {
                FirstView()
            } else {
                MainView()
                    .environmentObject(myProfileVM)
            }
        }
    }
}
