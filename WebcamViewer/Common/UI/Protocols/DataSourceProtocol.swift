//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import Foundation

public protocol SectionProtocol {
  associatedtype Row

  var rows: [Row] { get }
}

public protocol DataSourceProtocol {
  associatedtype Section: SectionProtocol

  var sections: [Section] { get set }
}

extension DataSourceProtocol {
  func numberOfSections() -> Int {
    sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    guard let section = sections[safe: section] else { return 0 }
    return section.rows.count
  }

  func section(at index: Int) -> Section? {
    sections[safe: index]
  }
}

extension SectionProtocol {
  func row(at index: Int) -> Row? {
    rows[safe: index]
  }
}
