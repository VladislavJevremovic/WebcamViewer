//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class SelectionContentView: UIView {
  let tableView = UITableView.al_makeView()

  var onSelectCamera: ((Camera) -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods
  private func setupView() {
    backgroundColor = .systemBackground
    setupTableView()
  }

  func setupTableView() {
    addSubview(tableView)
    tableView.register(SelectionTableViewCell.self)
    tableView.contentInset.top = 10
    tableView.al_edgesEqualToSuperview()
  }
}
