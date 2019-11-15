//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  let localStore = UserDefaultsLocalStore(userDefaults: UserDefaults.standard)

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    StartupProcessService().execute(
      process: WindowSetupStartupProcess(scene: scene, localStore: localStore) { [weak self] window in
        self?.window = window
      }
    )
  }
}
