import UIKit
import MaterialComponents

class MasterViewController: MDCCollectionViewController {
  var labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".characters.map({ (c) -> String in
    return "\(c)"
  })

  private let appBar = MDCAppBar()

  override func loadView() {
    super.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.isNavigationBarHidden = true

    self.addChildViewController(appBar.headerViewController)
    self.appBar.headerViewController.headerView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    self.appBar.headerViewController.headerView.trackingScrollView = self.collectionView

    appBar.addSubviewsToParent()

    self.title = "Testing"

    self.collectionView?.backgroundColor = .white

    self.collectionView?.register(MDCCollectionViewTextCell.self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let path = IndexPath.init(item: 0, section: 0)
    self.collectionView?.scrollToItem(at: path, at: UICollectionViewScrollPosition.bottom, animated: false)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath) as MDCCollectionViewTextCell
    cell.textLabel?.text = labels[indexPath.item]
    return cell
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.labels.count
  }

  override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    return CGSize(width: width, height: 100)
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = ListViewController()
    let nc = UINavigationController(rootViewController: vc)
    nc.isNavigationBarHidden = true
    self.showDetailViewController(nc, sender: nil)
  }

}
