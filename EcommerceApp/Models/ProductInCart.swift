//
//  ProductInCart.swift
//  EcommerceApp
//
//

import Foundation

struct ProductInCart: Identifiable {
    var id: String {
        return product.id
    }
    let product: Product
    var quantity: Int
    
    var displayTotalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = quantity * product.price
        return formatter.string(from: total as NSNumber) ?? "$0.00"
    }
    
}
