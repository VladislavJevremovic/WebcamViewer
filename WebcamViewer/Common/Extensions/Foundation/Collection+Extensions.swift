//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

extension Collection {
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
