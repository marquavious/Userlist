//
//  MappView.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/9/24.
//

import MapKit
import SwiftUI

struct MapView: View {

  struct Constants {
    static let cameraRenderingDistace: Double = 100_000
  }

  var title: String
  private var coordinate: CLLocationCoordinate2D
  @State private var position: MapCameraPosition

  init(title: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.position = .camera(
      .init(centerCoordinate: coordinate, distance: Constants.cameraRenderingDistace)
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
      .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
    }.onChange(of: coordinate) {
      if CLLocationCoordinate2DIsValid(coordinate) {
        position = .camera(
          .init(centerCoordinate: coordinate, distance: Constants.cameraRenderingDistace)
        )
      }
    }
  }
}

#Preview {
  MapView(title: "NY", coordinate: .newYork)
    .frame(
      width: UIScreen.main.bounds.width - 16,
      height: Theme.MediaSizes.mediaHeight.height
    )
    .clipShape(RoundedRectangle(cornerRadius: Theme.Geomitry.cornerRadius.radius))
}

extension CLLocationCoordinate2D: @retroactive Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}
