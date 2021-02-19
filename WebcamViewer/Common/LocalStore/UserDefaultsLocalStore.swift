//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol LocalStore: SettingsLocalStore, CameraStore {
  func clear()
}

internal protocol SettingsLocalStore: AnyObject {
  var selectedCameraIndex: Int { get set }
  var selectedCamera: Camera { get }
}

internal protocol CameraStore: AnyObject {
  var cameraArray: CameraArray { get }
  var cameraCount: Int { get }
  var previousCamera: Camera { get }
  var nextCamera: Camera { get }

  func indexOf(_ camera: Camera) -> Int
  func cameraAt(_ index: Int) -> Camera
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

  private let userDefaults: UserDefaults

  // MARK: - SettingsLocalStore
  var selectedCameraIndex: Int {
    get {
      userDefaults.integer(forKey: Keys.selectedCameraIndex.key)
    }
    set {
      userDefaults.set(newValue, forKey: Keys.selectedCameraIndex.key)
    }
  }

  var selectedCamera: Camera {
    cameraArray[selectedCameraIndex]
  }

  // MARK: - CameraStore
  var cameraArray: CameraArray {
    Camera.loadCameraArray()
  }

  var cameraCount: Int {
    cameraArray.count
  }

  var previousCamera: Camera {
    cameraAt((selectedCameraIndex - 1 + cameraCount) % cameraCount)
  }

  var nextCamera: Camera {
    cameraAt((selectedCameraIndex + 1) % cameraCount)
  }

  // MARK: - Lifecycle
  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  // MARK: - CameraStore
  func indexOf(_ camera: Camera) -> Int {
    cameraArray.firstIndex { $0 == camera } ?? 0
  }

  func cameraAt(_ index: Int) -> Camera {
    cameraArray[index]
  }

  // MARK: - LocalStore
  func clear() {
    userDefaults.dictionaryRepresentation().forEach { key, _ in
      userDefaults.removeObject(forKey: key)
    }
  }
}
