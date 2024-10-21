//
//  ProfileStubs.swift
//  ServerSideProfileEditor
//
//  Created by Marquavious Draggon on 10/20/24.
//

import Foundation

struct ProfileStubs {
  static let profilePictures: [String] = [
    "https://cdn.profoto.com/cdn/053149e/contentassets/d39349344d004f9b8963df1551f24bf4/profoto-albert-watson-steve-jobs-pinned-image-original.jpg?width=1280&quality=75&format=jpg",
    "https://imgcdn.stablediffusionweb.com/2024/6/12/4d688bcf-f53b-42b6-a98d-3254619f3b58.jpg"
  ]

  static let banners: [String] = [
    "https://images.photowall.com/products/56987/outer-space-4.jpg?h=699&q=85",
    "https://upload.wikimedia.org/wikipedia/commons/3/37/Skyline-4582510_1920.jpg"
  ]

  static let media: [String] = [
    "https://i.imgur.com/ApCOa7j.jpeg",
    "https://i.imgur.com/FRf8t4A.png",
    "https://i.imgur.com/vFTPjU4.png",
    "https://i.natgeofe.com/k/a6c9f195-de20-445d-9d36-745ef56042c5/OG_Colosseum_Ancient-Rome_KIDS_1122.jpg?w=1436&h=978",
    "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
  ]

  static let usernames: [String] = [
    "Paul",
    "Rachel",
    "Marq",
    "Joe",
    "Her",
    "Him",
    "Johnny Appleseed"
  ]

  static let arrayOfTexts: [String] = [
    StringGenerator.generateRandomString(),
    StringGenerator.generateRandomString(),
    StringGenerator.generateRandomString(),
    StringGenerator.generateRandomString()
  ]
}
