//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

extension Date {
  var millisecondsSince1970: Int64 {
    Int64((timeIntervalSince1970 * 1_000.0).rounded())
  }
}
