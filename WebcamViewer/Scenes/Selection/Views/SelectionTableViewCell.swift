//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class SelectionTableViewCell: SubtitleTableViewCell {
  typealias ViewModel = Camera

  func update(_ viewModel: ViewModel) {
    textLabel?.text = viewModel.name
    detailTextLabel?.text = viewModel.location
  }
}
