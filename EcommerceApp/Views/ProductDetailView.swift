//
//  ProductDetailView.swift
//  EcommerceApp
//
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    @State var addToCartAlert = false
    @Environment(CartManager.self) var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(product.image)
                    .bannerImageStyle()
                Group {
                    Text(product.title)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.bottom, 5)
                    Text(product.description)
                        .font(.system(size: 15))
                        .padding(.bottom, 15)
                    Button(action: {
                        cartManager.addToCart(product: product)
                        addToCartAlert = true
                    }, label: {
                        Text("Add to Cart")
                    })
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .alert("Added To Cart", isPresented: $addToCartAlert, actions: {
            Button(role: .none) {
                
            } label: {
                Text("OK")
            }
        }, message: {
            Text("You have added \(product.title) to your cart!")
        })
    }
}

#Preview {
    ProductDetailView(product: ProductsClient.fetchProducts()[0])
        .environment(CartManager())
}
