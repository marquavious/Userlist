//
//  CreateURLMediaPhotoCarouselView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 11/1/24.
//

import Foundation
import SwiftUI

@Observable
class CreateURLMediaPhotoCarouselViewData: ObservableObject {
  var photoArray: [PhotoData]

  init(photoArray: [PhotoData]) {
    self.photoArray = photoArray
  }
}

struct CreateURLMediaPhotoCarouselView: View {

  @State var height: CGFloat = .zero

  var photoData: CreateURLMediaPhotoCarouselViewData
  var didUpdateMedia: (([PhotoData]) -> Void)

  init(photoArray: [PhotoData], didUpdateMedia: @escaping ([PhotoData]) -> Void) {
    self.photoData = CreateURLMediaPhotoCarouselViewData(photoArray: photoArray)
    self.didUpdateMedia = didUpdateMedia
  }

  var body: some View {
    VStack(spacing: 8) {
      ForEach(Array(photoData.photoArray.enumerated()), id: \.offset) { index, data in
          HStack(alignment: .center) {
            CreateURLMediaPhotoView(
              url: data.urlString ?? "",
              contentMode: CreateURLMediaPhotoView.ContentModeOption.optionMode(contentMode: data.contentMode)
            ) { updatededPhotoDataOne in
              updateMedia(index: index, photoData: updatededPhotoDataOne)
            }
            Button {
              self.photoData.photoArray.remove(at: index)
              didUpdateMedia(self.photoData.photoArray)
            } label: {
              ZStack {
                Rectangle()
                  .fill(Color.gray)
                  .opacity(0.1)
                  .cornerRadius(8)
                  .frame(maxWidth: 32)
                  .frame(maxHeight: .infinity)
                Image(systemName: "x.circle")
                  .renderingMode(.template)
                     .foregroundColor(.blue)
              }
            }
            .buttonStyle(.plain)
          }
          .fixedSize(horizontal: false, vertical: true)
      }

      Button {
        addOne(photoData: .emptyInstance())
      } label: {
        ZStack {
          Rectangle()
            .fill(Color.gray)
            .opacity(0.1)
            .cornerRadius(8)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 32)
          Image(systemName: "plus.circle")
            .renderingMode(.template)
        }
      }
      .padding(.bottom, 4)

    }
  }

  func addOne(photoData: PhotoData) {
    self.photoData.photoArray.append(photoData)
    didUpdateMedia(self.photoData.photoArray)
  }

  func updateMedia(index: Int, photoData: PhotoData) {
    self.photoData.photoArray[index] = photoData
    didUpdateMedia(self.photoData.photoArray)
  }
}

#Preview {
  CreateURLMediaPhotoCarouselView(photoArray: [PhotoData.emptyInstance()]) { _ in

  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
  }
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
