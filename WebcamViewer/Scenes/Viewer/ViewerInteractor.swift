//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol ViewerBusinessLogic {
  func navigateToCamera(_ camera: Camera)
  func navigateToSelectedCamera()
  func navigateToPreviousCamera()
  func navigateToNextCamera()
}

internal final class ViewerInteractor: ViewerBusinessLogic {
  var presenter: ViewerPresentationLogic?
  private let localStore: LocalStore

  init(localStore: LocalStore) {
    self.localStore = localStore
  }

  // MARK: - ViewerBusinessLogic
  func navigateToCamera(_ camera: Camera) {
    localStore.selectedCameraIndex = localStore.indexOf(camera)
    presenter?.presentCamera(camera)
  }

  func navigateToSelectedCamera() {
    navigateToCamera(localStore.selectedCamera)
  }

  func navigateToPreviousCamera() {
    navigateToCamera(localStore.previousCamera)
  }

  func navigateToNextCamera() {
    navigateToCamera(localStore.nextCamera)
  }
}
