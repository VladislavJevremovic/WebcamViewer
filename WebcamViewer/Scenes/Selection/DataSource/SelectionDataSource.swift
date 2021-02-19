//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class SelectionDataSource: NSObject, DataSourceProtocol, UITableViewDataSource {
  var sections: [SelectionSection]

  init(cameraArray: CameraArray) {
    sections = []
    super.init()
    sections.append(buildMainSection(cameraArray: cameraArray))
  }

  // MARK: - UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int {
    numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as SelectionTableViewCell

    guard let row = section(at: indexPath.section)?.row(at: indexPath.row) else {
      return cell
    }

    switch row {
    case let .item(viewModel):
      cell.update(viewModel)
      return cell
    }
  }

  // MARK: - Private Methods
  private func buildMainSection(cameraArray: CameraArray) -> SelectionSection {
    var rows = [SelectionRow]()
    for camera in cameraArray {
      rows.append(SelectionRow.item(camera))
    }

    let section = SelectionSection.main(rows: rows)
    return section
  }
}
