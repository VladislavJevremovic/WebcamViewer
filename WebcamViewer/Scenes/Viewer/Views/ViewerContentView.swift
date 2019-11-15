//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

internal final class ViewerContentView: UIView {
  let imageView = UIImageView.al_makeView()
  let titleLabel = UILabel.al_makeView()
  let subtitleLabel = UILabel.al_makeView()

  var onSwipeLeft: (() -> Void)?
  var onSwipeRight: (() -> Void)?
  var onSwipeUp: (() -> Void)?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods
  private func setupView() {
    backgroundColor = .systemBackground
    setupImageView()
    setupTitleLabel()
    setupSubtitleLabel()
    setupGestureRecognizers()
  }

  private func setupImageView() {
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    imageView.al_edgesEqualToSuperview()
  }

  private func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
    titleLabel.textColor = .label
    titleLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
    titleLabel.shadowOffset = CGSize(width: 1, height: 1)
    titleLabel.isUserInteractionEnabled = false
    titleLabel.textAlignment = .center
    titleLabel.lineBreakMode = .byTruncatingTail
    titleLabel.al_pinTopToSuperview(8)
    titleLabel.al_centerHorizontallyToSuperview()
  }

  private func setupSubtitleLabel() {
    addSubview(subtitleLabel)
    subtitleLabel.font = UIFont.systemFont(ofSize: 12)
    subtitleLabel.textColor = .label
    subtitleLabel.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
    subtitleLabel.shadowOffset = CGSize(width: 1, height: 1)
    subtitleLabel.isUserInteractionEnabled = false
    subtitleLabel.textAlignment = .center
    subtitleLabel.lineBreakMode = .byTruncatingTail
    subtitleLabel.al_pinUnder(titleLabel, offset: 8)
    subtitleLabel.al_centerHorizontallyToSuperview()
  }

  private func setupGestureRecognizers() {
    let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(
      target: self,
      action: #selector(imageLeftSwipeGestureRecognized)
    )
    leftSwipeGestureRecognizer.direction = .left
    imageView.addGestureRecognizer(leftSwipeGestureRecognizer)

    let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(
      target: self,
      action: #selector(imageRightSwipeGestureRecognized)
    )
    rightSwipeGestureRecognizer.direction = .right
    imageView.addGestureRecognizer(rightSwipeGestureRecognizer)

    let upSwipeGestureRecognizer = UISwipeGestureRecognizer(
      target: self,
      action: #selector(imageUpSwipeGestureRecognized)
    )
    upSwipeGestureRecognizer.direction = .up
    imageView.addGestureRecognizer(upSwipeGestureRecognizer)
  }

  @objc
  private func imageLeftSwipeGestureRecognized() {
    onSwipeLeft?()
  }

  @objc
  private func imageRightSwipeGestureRecognized() {
    onSwipeRight?()
  }

  @objc
  private func imageUpSwipeGestureRecognized() {
    onSwipeUp?()
  }

  // MARK: - Public Methods
  func updateWithCamera(_ camera: Camera) {
    titleLabel.text = camera.name
    subtitleLabel.text = "\(camera.location), \(camera.country)"
    imageView.download(from: camera.url)
  }
}
