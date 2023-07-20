//
//  SettingScreenDemoApp.swift
//  SettingScreenDemo
//
//  Created by Marco Alonso Rodriguez on 16/07/23.
//

import SwiftUI

@main
struct SettingScreenDemoApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
