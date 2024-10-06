//
//  mybillsApp.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/8/12.
//

import SwiftUI
import SwiftData

@main
struct mybillsApp: App {
    var body: some Scene {
        WindowGroup {
//            HomeView()
            ContentView()
//            ScannerContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
