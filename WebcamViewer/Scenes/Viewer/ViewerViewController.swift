//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol ViewerDisplayLogic: AnyObject {}

internal final class ViewerViewController: UIViewController, ViewerDisplayLogic {
  var interactor: ViewerBusinessLogic?
  var router: ViewerRoutingLogic?
  private let contentView = ViewerContentView.al_makeView()
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
  let localStore: LocalStore

  init(localStore: LocalStore, delegate: ViewerRouterDelegate?) {
    self.localStore = localStore
    super.init(nibName: nil, bundle: nil)

    let interactor = ViewerInteractor()
    let presenter = ViewerPresenter()
    let router = ViewerRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()

    contentView.updateWithCamera(localStore.selectedCamera)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods
  private func setupView() {
    setupContentView()
  }

  private func setupContentView() {
    view.addSubview(contentView)
    contentView.onSwipeLeft = { [weak self] in
      self?.navigateToNextCamera()
    }
    contentView.onSwipeRight = { [weak self] in
      self?.navigateToPreviousCamera()
    }
    contentView.onSwipeUp = { [weak self] in
      self?.router?.navigateToCameraSelection()
    }
    contentView.al_edgesEqualToSuperview()
  }

  func navigateToNextCamera() {
    updateWithCamera(localStore.nextCamera)
  }

  func navigateToPreviousCamera() {
    updateWithCamera(localStore.previousCamera)
  }

  // MARK: - Public Methods
  func updateWithCamera(_ camera: Camera) {
    localStore.selectedCameraIndex = localStore.indexOf(camera)
    contentView.updateWithCamera(camera)
  }

  // MARK: - ViewerDisplayLogic
}
