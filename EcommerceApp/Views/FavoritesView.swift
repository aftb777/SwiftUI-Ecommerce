//
//  FavoritesView.swift
//  EcommerceApp
//
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(FavoritesManager.self) var favoritesManager: FavoritesManager
    
    fileprivate func FavoriteRow(favorite: Product) -> some View {
        HStack {
            Image(favorite.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
            VStack(alignment: .leading) {
                Text(favorite.title)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.bottom, 1)
                Text(favorite.description)
                    .lineLimit(2)
                    .font(.system(size: 15))
                    .padding(.bottom, 1)
            }
            Button(action: {
                removeFromFavorites(product: favorite)
            }, label: {
                Image(systemName: "heart.fill")
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(favoritesManager.products) { favorite in
                    FavoriteRow(favorite: favorite)
                }
            }
            .overlay(content: {
                if favoritesManager.products.count == 0 {
                    Text("Nothing to see here")
                }
            })
            .navigationTitle("Favorites")
        }
    }
    
    func removeFromFavorites(product: Product) {
        favoritesManager.products.removeAll { $0.id == product.id }
    }
    
}

#Preview {
    FavoritesView()
        .environment(FavoritesManager())
}
