//
//  PurchaseSuccessView.swift
//  Ecommerce
//
//

import SwiftUI

struct PurchaseSuccessView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .foregroundColor(Color.green)
                .font(.system(size: 60))
                .padding(.bottom)
           Text("Thank you for your purchase!")
                .font(.system(size: 15))
        }
    }
}

struct PurchaseSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseSuccessView()
    }
}
