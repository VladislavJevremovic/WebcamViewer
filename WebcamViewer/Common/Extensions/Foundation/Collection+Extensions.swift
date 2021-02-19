//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

extension Collection {
	subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
	}
}
