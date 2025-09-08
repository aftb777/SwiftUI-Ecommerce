//
//  PurchaseFailedView.swift
//  Ecommerce
//
//

import SwiftUI

struct PurchaseFailedView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle")
                .foregroundColor(Color.red)
                .font(.system(size: 60))
                .padding(.bottom)
           Text("Purchase failed. Please try again.")
                .font(.system(size: 15))
        }
    }
}

struct PurchaseFailedView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseFailedView()
    }
}
