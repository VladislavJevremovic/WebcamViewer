//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol ViewerPresentationLogic {
  func presentCamera(_ camera: Camera)
}

internal final class ViewerPresenter: ViewerPresentationLogic {
  weak var viewController: ViewerDisplayLogic?

  // MARK: - ViewerPresentationLogic
  func presentCamera(_ camera: Camera) {
    viewController?.displayCamera(camera)
  }
}
