//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal typealias CameraArray = [Camera]

internal struct Camera: Codable {
  let location: String
  let country: String
  let interval: Int
  let name: String
  let url: String

  // TODO: refactor
  static func loadCameraArray() -> CameraArray {
    var result = CameraArray()
    guard let path = Bundle.main.path(forResource: "Data", ofType: "json") else { return result }

    do {
      let url = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: url)
      result = try CameraArray(data: data)
    } catch {}

    return result
  }
}

extension Array where Element == CameraArray.Element {
  init(data: Data) throws {
    self = try JSONDecoder.default.decode(CameraArray.self, from: data)
  }
}