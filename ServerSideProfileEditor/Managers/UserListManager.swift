//
//  UserListManager.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/21/24.
//

import Foundation

@Observable
class UserListManager: ObservableObject {
  var users = [Profile.generatRandomProfile(id:"0"), Profile.generatRandomProfile(id:"1"), Profile.generatRandomProfile(id:"2")]

  public static let shared = UserListManager()

  private init() {}
}
