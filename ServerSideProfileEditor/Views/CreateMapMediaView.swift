//
//  CreateMapMediaView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/12/24.
//

import Foundation
import SwiftUI
import CoreLocation

struct CreateMapMediaView: View {

  private enum TextField: CaseIterable, Identifiable {
    case title
    case latitude
    case longitude

    var id: String {
      UUID().uuidString
    }
  }

  @State var title: String
  @State var latitude: CLLocationDegrees
  @State var longitude: CLLocationDegrees
  @FocusState private var focusedTextField: TextField?

  var didUpdateMedia: ((String, CLLocationDegrees, CLLocationDegrees) -> Void)

  var body: some View {
    VStack {
      CustomTextField(
        title: "Marker Title",
        textfieldPrompt: "Title...",
        isRequired: true,
        text: $title
      )
      .environment(\.isFocused, focusedTextField == .title)
      .focused($focusedTextField, equals: .title)
      CustomTextField(
        title: "Latitude",
        textfieldPrompt: "Latitude...",
        iconSystemImageName: "mappin.and.ellipse.circle",
        isRequired: true,
        text: Binding(get: { String(latitude) }, set: { latitude = Double($0) ?? 0 })
      )
      .environment(\.isFocused, focusedTextField == .latitude)
      .focused($focusedTextField, equals: .latitude)
      .keyboardType(.numberPad)
      CustomTextField(
        title: "Longitude",
        textfieldPrompt: "Longitude...",
        iconSystemImageName: "mappin.and.ellipse.circle",
        isRequired: true,
        text: Binding(get: { String(longitude) }, set: { longitude = Double($0) ?? 0 })
      )
      .environment(\.isFocused, focusedTextField == .longitude)
      .focused($focusedTextField, equals: .longitude)
      .keyboardType(.numberPad)

      Button {
        autoFill()
      } label: {
        Text("\(Image(systemName: "dice")) Randomize Location")
          .font(.subheadline)
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)

    }.onChange(of: latitude) {
      updateMedia()
    }.onChange(of: longitude) {
      updateMedia()
    }.onChange(of: title) {
      updateMedia()
    }
  }

  private func autoFill() {
    let mapData = ProfileStubGenerator.randomLocation()
    if case let .mapView(title, latitude, longitude) = mapData {
      self.title = title
      self.latitude = latitude
      self.longitude = longitude
    }
  }

  private func updateMedia() {
    if !title.isEmpty && !latitude.isNaN && !longitude.isNaN {
      didUpdateMedia(title, latitude, longitude)
    }
  }
}
