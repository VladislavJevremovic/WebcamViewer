//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol SelectionDisplayLogic: AnyObject {}

internal final class SelectionViewController: UIViewController, SelectionDisplayLogic, UITableViewDelegate {
  var interactor: SelectionBusinessLogic?
  var router: SelectionRoutingLogic?
  private let contentView = SelectionContentView.al_makeView()
  private var dataSource = SelectionDataSource(cameraArray: Camera.loadCameraArray())
  override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
  let localStore: LocalStore

  init(localStore: LocalStore, delegate: SelectionRouterDelegate?) {
    self.localStore = localStore
    super.init(nibName: nil, bundle: nil)

    let interactor = SelectionInteractor()
    let presenter = SelectionPresenter()
    let router = SelectionRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods
  private func setupView() {
    setupContentView()

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelButtonAction)
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(filterButtonAction)
    )
  }

  private func setupContentView() {
    view.addSubview(contentView)
    contentView.tableView.dataSource = dataSource
    contentView.tableView.delegate = self
    contentView.al_edgesEqualToSuperview()
  }

  @objc
  private func cancelButtonAction() {
    router?.dismiss(selectedCamera: nil)
  }

  @objc
  private func filterButtonAction() {
    //
  }

  // MARK: - UITableViewDelegate
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let row = dataSource.section(at: indexPath.section)?.row(at: indexPath.row) else { return }
    tableView.deselectRow(at: indexPath, animated: true)

    switch row {
    case let .item(camera):
      router?.dismiss(selectedCamera: camera)
    }
  }

  // MARK: - SelectionDisplayLogic
}
