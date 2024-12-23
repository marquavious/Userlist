//
//  BlurView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/19/24.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

  let blurEffectStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // NO-OP
    }
}

extension UIVisualEffectView {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.contentView ? nil : view
    }
}

#Preview {
  BlurView(blurEffectStyle: .dark)
}
