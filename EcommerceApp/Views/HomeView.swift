//
//  HomeView.swift
//  EcommerceApp
//
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    @Environment(FavoritesManager.self) var favoritesManager: FavoritesManager
    @Environment(CartManager.self) var cartManager: CartManager
    @Environment(TabManager.self) var tabManager: TabManager
    
    fileprivate var NavigationBarView: some View {
        HStack {
            Spacer()
            Text("Ecommerce App")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
        }
        .overlay(alignment: .trailing) {
                Button(action: {
                    tabManager.selectedTab = 1
                }, label: {
                    ZStack {
                        Image(systemName: "cart.fill")
                            .foregroundStyle(Color.black)
                        if cartManager.productsInCart.count > 0 {
                            ZStack {
                                Circle()
                                Text("\(cartManager.displayTotalCartQuantity)")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.white)
                            }
                            .offset(CGSize(width: 10, height: -10))
                        }
                    }
                })
                .padding(.trailing)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    NavigationBarView
                    Image("banner")
                        .bannerImageStyle()
                    HStack {
                        Text("Featured")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading)
                        Spacer()
                        NavigationLink {
                            ProductGridView(filter: .featured)
                        } label: {
                            Text("View All")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.fetchProducts(filter: .featured)) { product in
                                ProductRowView(product: product)
                            }
                        }
                    }
                    .padding(.leading, 5)
                    HStack {
                        Text("Highly Rated")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading)
                        Spacer()
                        NavigationLink {
                            ProductGridView(filter: .highlyRated)
                        } label: {
                            Text("View All")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.fetchProducts(filter: .highlyRated)) { product in
                                ProductRowView(product: product)
                            }
                        }
                    }
                    .padding(.leading, 5)
                    Button(action: {
                        viewModel.showAllProducts = true
                    }, label: {
                        Text("See Full Catalog")
                    })
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $viewModel.showAllProducts) {
                ProductGridView(filter: .all)
            }
        }
    }
}
#Preview {
    HomeView()
        .environment(FavoritesManager())
        .environment(CartManager())
        .environment(TabManager())
}
