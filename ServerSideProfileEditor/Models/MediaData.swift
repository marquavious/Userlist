//
//  MediaData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUI

@Observable
class MediaData: Identifiable, Observable {

  let id: String
  var media: Media

  init(id: String = UUID().uuidString, media: Media) {
    self.id = id
    self.media = media
  }
}

extension MediaData: Equatable {
  static func == (lhs: MediaData, rhs: MediaData) -> Bool {
    lhs.id == rhs.id &&
    lhs.media == rhs.media
  }
}
