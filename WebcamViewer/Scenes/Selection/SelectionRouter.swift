//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol SelectionRoutingLogic {
  func dismiss(selectedCamera: Camera?)
}

internal protocol SelectionRouterDelegate: AnyObject {
  func dismiss(selectionViewController: SelectionViewController, selectedCamera: Camera?)
}

internal final class SelectionRouter: SelectionRoutingLogic {
  weak var viewController: SelectionViewController?
  weak var delegate: SelectionRouterDelegate?

  // MARK: - SelectionRoutingLogic
  func dismiss(selectedCamera: Camera? = nil) {
    guard let viewController = viewController else { return }
    delegate?.dismiss(selectionViewController: viewController, selectedCamera: selectedCamera)
  }
}
