//
//  SectionData.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation
import SwiftUICore

@Observable
class SectionData: Identifiable, ObservableObject {
  let id: String = UUID().uuidString
  var index: Int
  var title: String?
  var description: String?
  var layout: SectionLayout.Arrangement
  var mediaHeight: CGFloat?
  var mediaContentMode: ContentMode
  var alignment: SectionLayout.AlignmentGuide
  var media: Media?
  var separator: Separator

  init(
    index: Int = 0,
    title: String? = nil,
    description: String? = nil,
    layout: SectionLayout.Arrangement = .top,
    mediaHeight: CGFloat? = nil,
    mediaContentMode: ContentMode = .fill,
    alignment: SectionLayout.AlignmentGuide = .leading,
    media: Media? = nil,
    separator: Separator = .none
  ) {
    self.index = index
    self.title = title
    self.description = description
    self.layout = layout
    self.mediaHeight = mediaHeight
    self.mediaContentMode = mediaContentMode
    self.alignment = alignment
    self.media = media
    self.separator = separator
  }
}

extension SectionData: Equatable, Hashable {
  static func == (lhs: SectionData, rhs: SectionData) -> Bool {
    lhs.id == rhs.id &&
    lhs.index == rhs.index &&
    lhs.title == rhs.title &&
    lhs.description == rhs.description &&
    lhs.layout == rhs.layout &&
    lhs.mediaHeight == rhs.mediaHeight &&
    lhs.mediaContentMode == rhs.mediaContentMode &&
    lhs.alignment == rhs.alignment &&
    lhs.media == rhs.media
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

extension SectionData {
  static func stubs(
    index: Int = 0
  ) -> SectionData {
    let stubData = ProfileStubGenerator.randomSectionTupleData()

    return SectionData(
      index: index,
      title: stubData.title,
      description: stubData.description,
      layout: .allCases.randomElement() ?? .top,
      mediaContentMode: .allCases.randomElement()!,
      alignment: .leading,
      media: Bool.random() ? nil : Media.generateRandomMedia(),
      separator: .allCases.randomElement()!
    )
  }
}
