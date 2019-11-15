//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol LocalStore: SettingsLocalStore {
  func clear()
}

internal protocol SettingsLocalStore: AnyObject {
  var selectedCameraIndex: Int { get set }
}

internal final class UserDefaultsLocalStore: LocalStore {
  private enum Keys {
    case selectedCameraIndex

    var key: String {
      switch self {
      case .selectedCameraIndex:
        return "selected_camera_index"
      }
    }
  }

  let userDefaults: UserDefaults

  var selectedCameraIndex: Int {
    get {
      return userDefaults.integer(forKey: Keys.selectedCameraIndex.key)
    }
    set {
      userDefaults.set(newValue, forKey: Keys.selectedCameraIndex.key)
    }
  }

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func clear() {
    userDefaults.dictionaryRepresentation().forEach { key, _ in
      userDefaults.removeObject(forKey: key)
    }
  }
}
