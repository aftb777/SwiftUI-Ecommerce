//
//  ProductGridView.swift
//  EcommerceApp
//
//

import SwiftUI

struct ProductGridView: View {
    
    @State var viewModel: ProductGridViewModel
    
    init(filter: ProductFilter) {
        _viewModel = State(wrappedValue: ProductGridViewModel(filter: filter))
    }
    
    var body: some View {
        VStack {
            TwoColumnGrid {
                ForEach(viewModel.products) { product in
                    ProductRowView(product: product)
                }
            }
        }
    }
}

#Preview {
    ProductGridView(filter: .all)
}
