//
//  File.swift
//  
//
//  Created by Darot on 22/09/2022.
//

import Foundation
import SwiftUI
public struct UIViewState: ViewModifier {
    @Binding var uiModel: UIModel
    @State var showAlert = false
    @State var error = ""
    public init(uiModel: Binding<UIModel>) {
        _uiModel = uiModel
    }
    
    fileprivate func buttonEvent() -> some View {
        return Button("OK", role: .cancel) {
            // Intentionally unimplemented...no action needed
        }
    }
    public func body(content: Content) -> some View {
        ZStack {
            switch uiModel {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(2)
            case .content:
                content
            case .error(let err):
                handleMessage(err)
            case .nothing:
                Text("Nothing")
            case .location:
                Text("Getting location...")
            }
        }
    }
    fileprivate func handleMessage(_ message: String) -> some View {
        return VStack {
            // Intentionally unimplemented...placeholder view
        }
        .edgesIgnoringSafeArea(.all)
        .opacity(0)
        .onAppear {
            showAlert.toggle()
        }
        .alert(message, isPresented: $showAlert) {
            buttonEvent()
        }
    }
}

