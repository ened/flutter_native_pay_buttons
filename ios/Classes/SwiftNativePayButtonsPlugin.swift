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
    
    init(_ frame: CGRect, _ viewId: Int64, _ args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.args = [:]
    }
    
    func view() -> UIView {
        if #available(iOS 9.0, *) {
            let tmp = UIView(frame: self.frame)
            tmp.addSubview(PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .white))
            return tmp
        } else {
            return UIView()
        }
    }
}

extension SwiftNativePayButtonsPlugin : FlutterPlatformViewFactory {
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return PaymentButtonWrapper(frame, viewId, args)
    }
}
