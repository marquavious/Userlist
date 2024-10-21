//
//  RouterPath.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable public class RouterPath {
  var path: [RouterDestination] = []

  init() {}

  func navigate(to: RouterDestination) {
    path.append(to)
  }
}
