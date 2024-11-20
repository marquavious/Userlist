//
//  ProfileSectionEditorViewState.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/12/24.
//

import Foundation

class ProfileSectionEditorViewState {
  var id: String
  var index: Int
  var titleText: String?
  var descriptionText: String?
  var media: Media?
  var alignment: SectionLayout.AlignmentGuide
  var layout: SectionLayout.Arrangement

  init(
    id: String,
    index: Int,
    titleText: String?,
    descriptionText: String?,
    alignment: SectionLayout.AlignmentGuide,
    media: Media?,
    layout: SectionLayout.Arrangement
  ) {
    self.id = id
    self.index = index
    self.titleText = titleText
    self.descriptionText = descriptionText
    self.alignment = alignment
    self.media = media
    self.layout = layout
  }

  init(sectionData: SectionData) {
    self.id = sectionData.id
    self.index = sectionData.index
    self.titleText = sectionData.title
    self.descriptionText = sectionData.description
    self.alignment = sectionData.alignment
    self.media = sectionData.media
    self.layout = sectionData.layout
  }

  func copyState(_ state: ProfileSectionEditorViewState) {
    self.id = state.id
    self.index = state.index
    self.titleText = state.titleText
    self.descriptionText = state.descriptionText
    self.alignment = state.alignment
    self.media = state.media
    self.layout = state.layout
  }
}
