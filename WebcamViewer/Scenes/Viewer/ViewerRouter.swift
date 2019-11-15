//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol ViewerRoutingLogic {
  func navigateToCameraSelection()
}

internal protocol ViewerRouterDelegate: AnyObject {}

internal final class ViewerRouter: ViewerRoutingLogic, SelectionRouterDelegate {
  weak var viewController: ViewerViewController?
  weak var delegate: ViewerRouterDelegate?

  // MARK: - ViewerRoutingLogic
  func navigateToCameraSelection() {
    guard let viewController = viewController else { return }
    let cameraSelectionViewController = SelectionViewController(
      localStore: viewController.localStore,
      delegate: self
    )
    let navigationController = UINavigationController(rootViewController: cameraSelectionViewController)
    viewController.present(navigationController, animated: true, completion: nil)
  }

  // MARK: - SelectionRouterDelegate
  func dismiss(selectionViewController: SelectionViewController, selectedCamera: Camera?) {
    viewController?.dismiss(animated: true)
    if let camera = selectedCamera {
      viewController?.updateWithCamera(camera)
    }
  }
}
