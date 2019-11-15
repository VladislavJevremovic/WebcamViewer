//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

extension UIView {
  class func al_makeView() -> Self {
    let instance = self.init()
    instance.translatesAutoresizingMaskIntoConstraints = false
    return instance
  }

  func al_edgesEqualTo(_ view: UIView) {
    leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  func al_edgesEqualToSuperview() {
    guard let superview = superview else { return }
    al_edgesEqualTo(superview)
  }

  func al_centerHorizontallyTo(_ view: UIView) {
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }

  func al_centerHorizontallyToSuperview() {
    guard let superview = superview else { return }
    al_centerHorizontallyTo(superview)
  }

  func al_pinTopTo(_ view: UIView, offset: CGFloat = 0) {
    topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset).isActive = true
  }

  func al_pinTopToSuperview(_ offset: CGFloat = 0) {
    guard let superview = superview else { return }
    al_pinTopTo(superview, offset: offset)
  }

  func al_pinUnder(_ view: UIView, offset: CGFloat = 0) {
    topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: offset).isActive = true
  }
}
