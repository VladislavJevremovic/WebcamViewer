//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal enum SelectionSection: SectionProtocol {
  case main(rows: [SelectionRow])

  var rows: [SelectionRow] {
    switch self {
    case .main(let rows):
      return rows
    }
  }
}
