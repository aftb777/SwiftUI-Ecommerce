//
//  PaymentButton.swift
//  Ecommerce
//
//

import SwiftUI
import PassKit

struct PaymentButton: UIViewRepresentable {
    
    var action: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    func makeUIView(context: Context) -> UIView {
        context.coordinator.button
    }
    
    func updateUIView(_ rootView: UIView, context: Context) {
        context.coordinator.action = action
    }
}

class Coordinator: NSObject {
    var action: () -> Void
    var button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .automatic)
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init()
        button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
    }
    
    @objc
    func callback(_ sender: Any) {
        action()
    }
}
