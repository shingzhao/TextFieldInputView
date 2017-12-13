import UIKit
import MaterialComponents

class ListViewController: UIViewController {
  override var inputAccessoryViewController: UIInputViewController? {
    return self.input
  }

  override var inputAccessoryView: UIView? {
    if #available(iOS 9.0, *) {
      return self.inputAccessoryViewController?.view
    } else {
      return nil
    }
  }

  override var canBecomeFirstResponder: Bool {
    return true
  }

  let input = MDCInputViewController()
  let appBar = MDCAppBar()

  init() {
    super.init(nibName: nil, bundle: nil)

    self.addChildViewController(appBar.headerViewController)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Detail"
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true

    appBar.addSubviewsToParent()
    appBar.headerViewController.headerView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
    appBar.headerViewController.headerView.canOverExtend = false
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    let rect = self.view.convert(self.view.bounds, to: nil)
    self.input.rect = rect
  }
}
