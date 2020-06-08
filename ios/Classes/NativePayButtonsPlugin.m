#import "NativePayButtonsPlugin.h"
#if __has_include(<native_pay_buttons/native_pay_buttons-Swift.h>)
#import <native_pay_buttons/native_pay_buttons-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_pay_buttons-Swift.h"
#endif

@implementation NativePayButtonsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativePayButtonsPlugin registerWithRegistrar:registrar];
}
@end
