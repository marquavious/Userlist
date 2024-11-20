//
//  UserDatabase.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

@Observable
class UserDatabase: ObservableObject {
  var allUsers = [
    ProfileData.generatRandomProfile(id:"0"),
    ProfileData.generatRandomProfile(id:"1"),
    ProfileData.generatRandomProfile(id:"2")
  ]

  public static let shared = UserDatabase()

  private init() {}
}
