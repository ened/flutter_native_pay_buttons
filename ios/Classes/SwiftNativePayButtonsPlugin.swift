import Flutter
import PassKit
import UIKit

public class SwiftNativePayButtonsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_pay_buttons", binaryMessenger: registrar.messenger())
    let instance = SwiftNativePayButtonsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    registrar.register(instance, withId: "asia.ivity/native_pay_button")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

class PaymentButtonWrapper: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let args: [String:Any]
    
    let type: PKPaymentButtonType
    let style: PKPaymentButtonStyle
    
    init(_ frame: CGRect, _ viewId: Int64, _ args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.args = [:]
        
        if let args = args as? [String: Int],
            let type = PKPaymentButtonType(rawValue: args["type"] ?? -1),
            let style = PKPaymentButtonStyle(rawValue: args["style"] ?? -1) {
            self.style = style
            self.type = type
        } else {
            self.type = .plain
            self.style = .white
        }
    }
    
    func view() -> UIView {
        var button: PKPaymentButton
        if #available(iOS 9.0, *) {
            button = PKPaymentButton(paymentButtonType: self.type, paymentButtonStyle: self.style)
        } else {
            button = PKPaymentButton()
        }
        let tmp = UIView(frame: self.frame)
        tmp.addSubview(button)
        button.bindFrameToSuperviewBounds()
        
        return tmp
    }
}

extension SwiftNativePayButtonsPlugin : FlutterPlatformViewFactory {
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return PaymentButtonWrapper(frame, viewId, args)
    }
}

extension UIView {

    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
        }

    }
}
