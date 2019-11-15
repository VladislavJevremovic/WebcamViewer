//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class WindowSetupStartupProcess: StartupProcess {
  let scene: UIScene
  let localStore: LocalStore
  let completion: (UIWindow) -> Void

  init(scene: UIScene, localStore: LocalStore, completion: @escaping (UIWindow) -> Void) {
    self.scene = scene
    self.localStore = localStore
    self.completion = completion
  }

  func run(completion: @escaping (Bool) -> Void) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = ViewerViewController(localStore: localStore, delegate: nil)
    window.makeKeyAndVisible()
    self.completion(window)

    completion(true)
  }
}
