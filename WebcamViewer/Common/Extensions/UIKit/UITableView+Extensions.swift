//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    String(describing: self)
  }
}

extension UITableView {
  final func register<T: UITableViewCell>(_ cellType: T.Type) where T: Reusable {
      register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }

  final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: Reusable {
      guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
        fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) for type \(cellType.self).")
      }
      return cell
  }
}
