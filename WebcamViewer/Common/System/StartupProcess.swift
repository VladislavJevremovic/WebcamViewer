//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

internal protocol StartupProcess {
	func run(completion: @escaping (Bool) -> Void)
}
