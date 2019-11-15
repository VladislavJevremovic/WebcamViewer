//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal final class StartupProcessService {
  @discardableResult
  func execute(process: StartupProcess) -> StartupProcessService {
    process.run { success in
      guard success else { return }
    }

    return self
  }
}
