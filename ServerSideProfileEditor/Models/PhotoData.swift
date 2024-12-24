//
//  PhotoData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/26/24.
//

import Foundation
import SwiftUI

struct PhotoData: Equatable, Identifiable, Hashable {
  let id = UUID().uuidString
  var urlString: String?
  let contentMode: ContentMode
}

extension PhotoData {
  static func emptyInstance() -> PhotoData {
    PhotoData(urlString: "", contentMode: .fit)
  }

  static func randomInstance() -> PhotoData {
    PhotoData(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .fit)
  }

  static func stubs() -> PhotoData {
    PhotoData(urlString: ProfileStubGenerator.randomMediaPicture(), contentMode: .allCases.randomElement()!)
  }
}
