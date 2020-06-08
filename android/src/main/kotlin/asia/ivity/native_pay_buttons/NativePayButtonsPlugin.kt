package asia.ivity.native_pay_buttons

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/** NativePayButtonsPlugin */
public class NativePayButtonsPlugin : FlutterPlugin, MethodCallHandler {
    private var channel: MethodChannel? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "native_pay_buttons")
        channel?.setMethodCallHandler(this)

        binding.platformViewRegistry.registerViewFactory("asia.ivity/native_pay_button", object : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
            override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
                val layout = when (args?.let { it as Map<*, *> }?.let { it["style"] as? Int }
                        ?: 0) {
                    0 -> R.layout.googlepay_button
                    1 -> R.layout.googlepay_button_no_shadow
                    2 -> R.layout.buy_with_googlepay_button
                    3 -> R.layout.buy_with_googlepay_button_no_shadow
                    else -> R.layout.googlepay_button
                }


                val inflater = LayoutInflater.from(context)
                return object : PlatformView {
                    override fun getView(): View {
                        return inflater.inflate(layout, null)
                    }

                    override fun dispose() {
                    }
                }
            }
        })
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "native_pay_buttons")
            channel.setMethodCallHandler(NativePayButtonsPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
        channel = null
    }
}
