//
//  ScannerContentView.swift
//  mybills
//
//  Created by 俊润 Chen on 2024/9/27.
//

import SwiftUI

struct ScannerContentView: View {
    @State private var showScannerSheet = false
    @State private var texts:[ScanData] = []
    var body: some View {
        NavigationView{
            VStack{
                if texts.count > 0 {
                    List{
                        ForEach(texts){text in
                            NavigationLink(
                                destination:ScrollView{Text(text.content)},
                                label: {
                                    Text(text.content).lineLimit(1)
                            })
                        }
                    }
                }
                else {
                    Text("No scan yet")
                        .font(.title)
                }
            }
                .navigationTitle("Scan OCR")
                .navigationBarItems(trailing:
                    Button(action: {
                    self.showScannerSheet = true
                }, label: {
                    Image(systemName: "doc.text.viewfinder")
                        .font(.title)
                })
                    .sheet(isPresented: $showScannerSheet, content: {
                        makeScannerView()
                })
                )
        }
    }
//
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanDate = ScanData(content: outputText)
                self.texts.append(newScanDate)
            }
            self.showScannerSheet = false
        })
    }
}

#Preview {
    ScannerContentView()
}
