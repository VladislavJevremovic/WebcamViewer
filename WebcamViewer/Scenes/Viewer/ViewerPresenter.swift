//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol ViewerPresentationLogic {}

internal final class ViewerPresenter: ViewerPresentationLogic {
  weak var viewController: ViewerDisplayLogic?

  // MARK: - ViewerPresentationLogic
}
