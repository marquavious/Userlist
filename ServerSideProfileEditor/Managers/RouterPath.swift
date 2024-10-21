//
//  RouterPath.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

@MainActor
@Observable public class RouterPath {
  public var path: [RouterDestination] = []

  public init() {}

  public func navigate(to: RouterDestination) {
    path.append(to)
  }
}

public enum RouterDestination: Hashable {
  case profile
}
