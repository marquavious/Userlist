//
//  SectionData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

@Observable
class SectionData: Identifiable, ObservableObject {
  let id: String
  var index: Int
  var title: String?
  var description: String?
//  var mediaData: MediaData?

  init(
    id: String,
    index: Int,
    title: String? = nil,
    description: String? = nil
//    mediaData: MediaData? = nil
  ) {
    self.id = id
    self.index = index
    self.title = title
    self.description = description
//    self.mediaData = mediaData
  }
}

extension SectionData: Equatable, Hashable {
  static func == (lhs: SectionData, rhs: SectionData) -> Bool {
//    lhs.id == rhs.id &&
//    lhs.title == rhs.title &&
//    lhs.description == rhs.description &&
//    lhs.mediaData == rhs.mediaData

    lhs.id == rhs.id &&
    lhs.index == rhs.index &&
    lhs.title == rhs.title &&
    lhs.description == rhs.description
//   && lhs.mediaData == rhs.mediaData
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension SectionData {
  func copy() -> SectionData {
    //    SectionData(
    //      id: id ?? UUID().uuidString,
    //      index: index,
    //      title: title,
    //      description: description,
    //      mediaData: mediaData)
    SectionData(
      id: id,
      index: index,
      title: title,
      description: description)
  }

  static func stubs(
    id: String = UUID().uuidString,
    index: Int = 0
  ) -> SectionData {
    //    SectionData(
    //      id: UUID().uuidString,
    //      index: 0,
    //      title: "TITLE",
    //      description: "DESCRIPTION",
    //      mediaData: MediaData(
    //        media: .urlPhoto("https://i.imgur.com/ApCOa7j.jpeg".urlValue()),
    //        position: .top
    //      )
    //    )
    SectionData(
      id: id,
      index: index,
      title: "TITLE",
      description: "DESCRIPTION")
  }
}

