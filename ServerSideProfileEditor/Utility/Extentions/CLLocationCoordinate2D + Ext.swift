//
//  Ext + CLLocationCoordinate2D.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 12/23/24.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
}
