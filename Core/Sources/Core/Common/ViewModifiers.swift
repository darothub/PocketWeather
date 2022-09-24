//
//  File.swift
//  
//
//  Created by Darot on 22/09/2022.
//

import SwiftUI
public extension View {
    func handleViewState(uiModel: Binding<UIModel>) -> some View {
        self.modifier(UIViewState(uiModel: uiModel))
    }
}
