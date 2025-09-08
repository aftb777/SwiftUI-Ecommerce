//
//  CartView.swift
//  EcommerceApp
//
//

import SwiftUI

struct CartView: View {
    
    @Environment(CartManager.self) var cartManager: CartManager
    
    fileprivate func CartRow(productInCart: ProductInCart) -> some View {
        HStack {
            Image(productInCart.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(productInCart.product.title)
                    .font(.system(size: 15))
                    .padding(.bottom, 1)
                Text(productInCart.product.displayPrice)
                    .font(.system(size: 15, weight: .bold))
                Stepper("Quantity \(productInCart.quantity)") {
                    cartManager.addToCart(product: productInCart.product)
                } onDecrement: {
                    cartManager.removeFromCart(product: productInCart.product)
                }
            }
        }
    }
    
    var body: some View {
        
        @Bindable var cartManager = cartManager
        
        VStack {
            List {
                ForEach(cartManager.productsInCart) { productInCart in
                    CartRow(productInCart: productInCart)
                }
            }
            VStack(spacing: 0) {
                Divider()
                HStack {
                    Text("Total: \(cartManager.displayTotalCartQuantity) items")
                        .font(.system(size: 16))
                    Spacer()
                    Text(cartManager.displayTotalCartPrice)
                        .font(.system(size: 16, weight: .bold))
                }
                .padding(.vertical, 30)
                .padding(.horizontal)
                PaymentButton(action: cartManager.pay)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 25)
            }
        }
        .sheet(isPresented: $cartManager.showPurchaseSuccessView, content: {
            PurchaseSuccessView()
                .presentationDetents([.medium])
        })
        .sheet(isPresented: $cartManager.showPurchaseFailureView, content: {
            PurchaseFailedView()
                .presentationDetents([.medium])
        })
    }
}

#Preview {
    CartView()
        .environment(CartManager())
}
