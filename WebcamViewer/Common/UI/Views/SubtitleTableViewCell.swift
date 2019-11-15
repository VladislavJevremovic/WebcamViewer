//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal class SubtitleTableViewCell: UITableViewCell, Reusable {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
