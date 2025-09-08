//
//  TwoColumnGrid.swift
//  EcommerceApp
//
//

import Foundation
import SwiftUI

struct TwoColumnGrid<Content: View>: View {
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                content()
            })
        }
    }
}

