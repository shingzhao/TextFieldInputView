import UIKit

extension UIView {
  var mdcSafeAreaInsets: UIEdgeInsets {
    #if swift(>=3.2)
      if #available(iOS 11.0, *) {
        return self.safeAreaInsets
      } else {
        return  .zero
      }
    #else
      return .zero
    #endif
  }
}

