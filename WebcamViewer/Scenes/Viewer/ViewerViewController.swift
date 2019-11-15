//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol ViewerDisplayLogic: AnyObject {
  func displayCamera(_ camera: Camera)
}

internal final class ViewerViewController: UIViewController, ViewerDisplayLogic {
  var interactor: ViewerBusinessLogic?
  var router: ViewerRoutingLogic?
  private let contentView = ViewerContentView.al_makeView()
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
  let localStore: LocalStore

  init(localStore: LocalStore, delegate: ViewerRouterDelegate?) {
    self.localStore = localStore
    super.init(nibName: nil, bundle: nil)

    let interactor = ViewerInteractor(localStore: localStore)
    let presenter = ViewerPresenter()
    let router = ViewerRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()

    Timer.scheduledTimer(
      withTimeInterval: 0.01,
      repeats: true
    ) { [weak self] _ in
      self?.interactor?.navigateToSelectedCamera()
    }
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
      self?.interactor?.navigateToNextCamera()
    }
    contentView.onSwipeRight = { [weak self] in
      self?.interactor?.navigateToPreviousCamera()
    }
    contentView.onSwipeUp = { [weak self] in
      self?.router?.navigateToCameraSelection()
    }
    contentView.al_edgesEqualToSuperview()
  }

  // MARK: - ViewerDisplayLogic
  func displayCamera(_ camera: Camera) {
    contentView.updateWithCamera(camera)
  }
}
