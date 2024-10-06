//
//  ScanData.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/27.
//

import Foundation

struct ScanData:Identifiable {
    var id = UUID()
    let content: String
    
    init(content: String) {
        self.content = content
    }
}
