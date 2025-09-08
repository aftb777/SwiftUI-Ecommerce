//
//  CartsManager.swift
//  EcommerceApp
//

import Foundation
import SwiftUI

@Observable
class CartManager {
    
    var productsInCart: [ProductInCart] = []
    var showPurchaseSuccessView = false
    var showPurchaseFailureView = false
    let paymentService = PaymentService()
    
    func addToCart(product: Product) {
        
        if let indexOfProductInCart = productsInCart.firstIndex(where: { $0.id == product.id }) {
            let currentQuantity = productsInCart[indexOfProductInCart].quantity
            let newQuantity = currentQuantity + 1
            productsInCart[indexOfProductInCart] = ProductInCart(product: product, quantity: newQuantity)
        } else {
            productsInCart.append(ProductInCart(product: product, quantity: 1))
        }
       
    }
    
    func removeFromCart(product: Product) {
        if let indexOfProductInCart = productsInCart.firstIndex(where: { $0.id == product.id }) {
            let currentQuantity = productsInCart[indexOfProductInCart].quantity
            if currentQuantity > 1 {
                let newQuantity = currentQuantity - 1
                productsInCart[indexOfProductInCart] = ProductInCart(product: product, quantity: newQuantity)
            } else if currentQuantity == 1 {
                productsInCart.remove(at: indexOfProductInCart)
            }
        }
    }
    
    var displayTotalCartQuantity: Int {
        return productsInCart.reduce(0) { $0 + $1.quantity }
    }
    
    var displayTotalCartPrice: String {
        let totalPrice = productsInCart.reduce(0) { $0 + ($1.product.price * $1.quantity) }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: totalPrice as NSNumber) ?? "$0.00"
    }
    
    func pay() {
        guard productsInCart.count > 0 else {
            return
        }
        paymentService.startPayment(productsInCart: productsInCart) { success in
            if success {
                self.productsInCart.removeAll()
                self.showPurchaseSuccessView = true
            } else {
                self.showPurchaseFailureView = true
            }
        }
    }
    
}
