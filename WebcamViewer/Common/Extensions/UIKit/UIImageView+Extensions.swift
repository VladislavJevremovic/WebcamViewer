//
//  Copyright © 2019 Vladislav Jevremović. All rights reserved.
//

import UIKit

extension UIImageView {
  internal enum ImageError: Error {
    case download
  }

  func download(
    from url: URL,
    contentMode mode: UIView.ContentMode = .scaleAspectFit,
    completion: ((Result<UIImage, Error>) -> Void)? = nil
  ) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else {
          DispatchQueue.main.async {
            self.image = nil
          }
          completion?(.failure(error ?? ImageError.download))
          return
        }

      DispatchQueue.main.async {
        self.image = image
      }
      completion?(.success(image))
    }
    .resume()
  }

  func download(
    from link: String,
    contentMode mode: UIView.ContentMode = .scaleAspectFit,
    completion: ((Result<UIImage, Error>) -> Void)? = nil
  ) {
    guard let url = URL(string: link) else { return }
    download(from: url, contentMode: mode, completion: completion)
  }
}
