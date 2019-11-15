//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol SelectionPresentationLogic {}

internal final class SelectionPresenter: SelectionPresentationLogic {
  weak var viewController: SelectionDisplayLogic?

  // MARK: - SelectionPresentationLogic
}
