//
//  MapView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/9/24.
//

import MapKit
import SwiftUI

struct MapView: View {

  struct Constants {
    static let cameraRenderingDistance: Double = 100_000
  }

  var title: String
  private var coordinate: CLLocationCoordinate2D
  @State private var position: MapCameraPosition

  init(title: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.position = .camera(
      .init(centerCoordinate: coordinate, distance: Constants.cameraRenderingDistance)
    )
    self.coordinate = coordinate
  }

  var body: some View {
    GeometryReader { proxy in
      Group {
        if CLLocationCoordinate2DIsValid(coordinate) {
          Map(
            position: $position,interactionModes: []
          ) {
            Marker(title, coordinate: coordinate)
          }
        } else {
          Color.black.overlay {
            Text("INVALID COORDINATES \(Image(systemName: "exclamationmark.triangle"))")
              .foregroundStyle(.red)
          }
        }
      }.frame(
        width: proxy.frame(in: .global).width,
        height: proxy.frame(in: .global).height
      )
      .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Geometry.cornerRadius))
    }.onChange(of: coordinate) {
      updateCameraPosition(coordinate: coordinate)
    }.onAppear {
      updateCameraPosition(coordinate: coordinate)
    }
  }

  private func updateCameraPosition(coordinate: CLLocationCoordinate2D) {
    position = .camera(
      .init(centerCoordinate: coordinate, distance: Constants.cameraRenderingDistance)
    )
  }
}

#Preview {
  MapView(title: "NY", coordinate: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935))
    .frame(
      width: UIScreen.main.bounds.width - 16,
      height: StyleConstants.MediaSizes.mediaHeight
    )
    .clipShape(RoundedRectangle(cornerRadius: StyleConstants.Geometry.cornerRadius))
}
