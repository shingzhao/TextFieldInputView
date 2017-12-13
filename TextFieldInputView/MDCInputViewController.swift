import UIKit
import MaterialComponents
//import googlemac_iPhone_Shared_GoogleKit_ImageBlending_ImageBlending
//import third_party_objective_c_material_components_ios_components_Buttons_Buttons

/// UIInputViewController to be shown as inputAccessoryViewController.
/// MDCInputViewController displays photo button, text field, and send button.
/// MDCInputViewController can be limited to within a given rect.
class MDCInputViewController: UIInputViewController {

  private let mdcInputView = MDCInputView()

  /// Setting rect will confine view to be within the rect.
  /// Useful for expanded trait collection where input view does not need to be full screen.
  var rect: CGRect = .zero {
    didSet {
      self.mdcInputView.rect = self.rect
    }
  }

  // MARK: - Override

  override func loadView() {
    self.view = self.mdcInputView
    self.view.translatesAutoresizingMaskIntoConstraints = false
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

    self.mdcInputView.rect = self.rect
  }
}

// Custom UIView to override MDCInputViewController's view.
// MDCInputView displays photo button, text field, and send button.
private class MDCInputView: UIView {
  fileprivate static let maxHeight: CGFloat = 80
  fileprivate static let textViewInset: CGFloat = 16

  /// Setting rect will confine view within the rect.
  var rect: CGRect = .zero {
    didSet {
      let size = self.sizeThatFits(
        CGSize(width: self.rect.width, height: .greatestFiniteMagnitude)
      )

      self.frame = CGRect(
        x: self.rect.origin.x,
        y: 0,
        width: size.width,
        height: size.height
      )

      self.invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    return self.sizeThatFits(CGSize(width: self.rect.width, height: .greatestFiniteMagnitude))
  }

  private let photoButton = MDCFlatButton()
  private let sendButton = MDCFlatButton()
  let textView = MDCMultilineTextField()
  private let divider = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.addSubview(self.textView)
    self.textView.textView?.delegate = self
    self.textView.expandsOnOverflow = false
    self.textView.underline?.color = .clear
    self.textView.backgroundColor = UIColor.blue.withAlphaComponent(0.25)
    self.textView.clearButtonMode = .never
    self.textView.placeholder = "Send a message"
    self.textView.textView?.backgroundColor = UIColor.red.withAlphaComponent(0.25)

    self.backgroundColor = .white

    //    let photoImage = UIImage(
    //      named: UIConstants.Images.photo
    //      )?.goo_image(
    //        with: .normal,
    //        color: .activeButtonColor
    //    )
    //    self.photoButton.setImage(photoImage, for: .normal)
    self.photoButton.setTitle("Photo", for: .normal)

    //    let sendImage = UIImage(
    //      named: UIConstants.Images.send
    //      )?.goo_image(
    //        with: .normal,
    //        color: .activeButtonColor
    //    )
    //    self.sendButton.setImage(sendImage, for: .normal)
    self.sendButton.setTitle("Send", for: .normal)

    self.divider.backgroundColor = .lightGray

    self.addSubview(self.photoButton)
    self.addSubview(self.sendButton)
    self.addSubview(self.divider)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let insets = self.mdcSafeAreaInsets

    let photoButtonSize = self.photoButton.sizeThatFits(self.frame.size)
    let sendButtonSize = self.sendButton.sizeThatFits(self.frame.size)

    self.photoButton.frame = CGRect(
      origin: CGPoint(
        x: insets.left,
        y: self.frame.height - photoButtonSize.height - insets.bottom),
      size: photoButtonSize
    )

    self.sendButton.frame = CGRect(
      origin: CGPoint(
        x: self.frame.width - sendButtonSize.width - insets.right,
        y: self.frame.height - sendButtonSize.height - insets.bottom),
      size: sendButtonSize
    )

    let height = self.frame.height - insets.bottom
    let width = self.frame.width -
      photoButtonSize.width -
      sendButtonSize.width -
      insets.left -
      insets.right
    self.textView.frame = CGRect(
      x: self.photoButton.frame.maxX,
      y: 0,
      width: width,
      height: height
    )

    self.divider.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let photoButtonSize = self.photoButton.sizeThatFits(size)
    let sendButtonSize = self.sendButton.sizeThatFits(size)

    let inset = self.mdcSafeAreaInsets
    let width = size.width - photoButtonSize.width - sendButtonSize.width - inset.left - inset.right
    let textViewSize = self.textView.textView?.sizeThatFits(CGSize(width: width, height: size.height)) ?? .zero
    let textViewHeight = textViewSize.height + MDCInputView.textViewInset * 2

    var height = ceil(
      Swift.min(
        Swift.max(
          textViewHeight,
          photoButtonSize.height,
          sendButtonSize.height
        ),
        MDCInputView.maxHeight
      )
    )

    height += inset.bottom

    return CGSize(width: size.width, height: height)
  }
}

// MARK: - UITextViewDelegate

extension MDCInputView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    // Allow expandsOnOverflow if textView height is less than maxHeight.
    // By allowing expandsOnOverflow, we are disabling textView scrolling.
    let size = CGSize(width: textView.bounds.width, height: .greatestFiniteMagnitude)
    let height = textView.sizeThatFits(size).height + MDCInputView.textViewInset * 2
    self.textView.expandsOnOverflow = height < MDCInputView.maxHeight

    // Update inputView height.
    self.invalidateIntrinsicContentSize()
  }
}

