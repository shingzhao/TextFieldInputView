//
//  UICollectionView+Register.swift
//  Voice
//

import UIKit

extension UICollectionView {
  func register<T: UICollectionViewCell>(_: T.Type) {
    self.register(T.self, forCellWithReuseIdentifier: NSStringFromClass(T.self))
  }

  func register<T: UICollectionReusableView>(_: T.Type,
                                             forSupplementaryViewOfKind elementKind: String) {
    self.register(T.self, forSupplementaryViewOfKind: elementKind,
                  withReuseIdentifier: NSStringFromClass(T.self))
  }

  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: NSStringFromClass(T.self), for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(NSStringFromClass(T.self))")
    }

    return cell
  }

  func dequeueReusableSupplementaryView<T: UICollectionViewCell>(ofKind elementKind: String,
                                                                 for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableSupplementaryView(ofKind: elementKind,
                                                      withReuseIdentifier: NSStringFromClass(T.self), for: indexPath) as? T else {
                                                        fatalError("Could not dequeue view with identifier: \(NSStringFromClass(T.self))")
    }

    return cell
  }
}

extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) {
    self.register(T.self, forCellReuseIdentifier: NSStringFromClass(T.self))
  }

  func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(T.self))
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(T.self), for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(NSStringFromClass(T.self))")
    }

    return cell
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(T.self)) as? T else {
      fatalError("Could not dequeue HeaderFooterView with identifier: \(NSStringFromClass(T.self))")
    }

    return view
  }
}

