//
//  CustomNavBar.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/19/24.
//

import Foundation

import Foundation
import SwiftUI

struct CustomNavBar: View {

    struct Constants {
        static let NavigationBarHeight: CGFloat = 50
    }

    @State var title: String
    @State var blurEffectStyle: UIBlurEffect.Style
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Binding var showNavigationBar: Bool

  var body: some View {
    ZStack {
      BlurView(blurEffectStyle: blurEffectStyle)
        .ignoresSafeArea()
        .frame(
          width: UIScreen.main.bounds.width,
          height: Constants.NavigationBarHeight
        )
        .opacity(showNavigationBar ? 1 : 0)
        .overlay(alignment: .center) {
          Text(title)
            .fontWeight(.semibold)
            .opacity(showNavigationBar ? 1 : 0)
            .foregroundStyle(colorScheme == .light ? .black: .white)
        }

      Image(systemName: "chevron.left")
        .font(.title2)
        .frame(width: 20,height: 20)
        .padding(8)
        .foregroundColor((showNavigationBar && colorScheme == .light) ? .black: .white)
        .background(
          showNavigationBar ? .clear : Color.black.opacity(0.5)
        )
        .clipShape(Circle())
        .padding([.horizontal])
        .allowsHitTesting(true)
        .onTapGesture { dismiss() }
        .background(Rectangle().fill(Color.black.opacity(0.0001)))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

#Preview {
  ProfileViewForPreviews()
}


extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
