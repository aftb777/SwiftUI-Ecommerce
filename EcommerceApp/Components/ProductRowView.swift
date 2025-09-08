//
//  ProductView.swift
//  EcommerceApp
//
//

import SwiftUI

struct ProductRowView: View {
    
    @Environment(FavoritesManager.self) var favoritesManager: FavoritesManager
    let product: Product
    
    var body: some View {
        NavigationLink {
            ProductDetailView(product: product)
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 8, bottomLeading: 0, bottomTrailing: 0, topTrailing: 8)))
                    .clipped()
                Group {
                    Text(product.title)
                        .lineLimit(1)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.primary)
                    Text("\(product.displayPrice)")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.primary)
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.yellow)
                        Text("\(product.displayRating)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.primary)
                    }
                }.padding(.horizontal, 5)
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(width: 150, height: 270)
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    if favoritesManager.products.contains(product) {
                        favoritesManager.products.removeAll { $0.id == product.id }
                    } else {
                        favoritesManager.products.append(product)
                    }
                }, label: {
                    Image(systemName: favoritesManager.products.contains(product) ? "heart.fill" : "heart")
                })
                .padding(8)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(uiColor: UIColor.lightGray).opacity(0.4), lineWidth: 1)
            }
        }
    }
    
}

#Preview {
    ProductRowView(product: ProductsClient.fetchProducts()[0])
        .environment(FavoritesManager())
}
