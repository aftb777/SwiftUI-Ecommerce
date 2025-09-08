//
//  HomeViewModel.swift
//  EcommerceApp
//
//

import Foundation
import SwiftUI
import Combine

@Observable
class HomeViewModel {
    
    var showAllProducts = false
    
    func fetchProducts(filter: ProductFilter) -> [Product] {
        switch filter {
        case .all:
            return ProductsClient.fetchProducts()
        case .featured:
            return ProductsClient.fetchProducts().filter({ $0.isFeatured })
        case .highlyRated:
            return ProductsClient.fetchProducts().filter({ $0.rating > 4 })
        }
    }
    
}
