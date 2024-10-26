//
//  PhotoData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct PhotoData: Equatable, Identifiable {
  let id: String
  let urlString: String?
  let contentMode: ContentMode
}

extension PhotoData {
  static func emptyInstance() -> PhotoData {
    PhotoData(id: "", urlString: "", contentMode: .fit)
  }
}
