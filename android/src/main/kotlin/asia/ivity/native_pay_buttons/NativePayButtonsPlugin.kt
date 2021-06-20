package asia.ivity.native_pay_buttons

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/** NativePayButtonsPlugin */
class NativePayButtonsPlugin : FlutterPlugin {
    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        binding.platformViewRegistry.registerViewFactory(
            "asia.ivity/native_pay_button",
            object : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
                override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
                    val layout = when (
                        args?.let { it as Map<*, *> }?.let { it["style"] as? Int }
                            ?: 0
                    ) {
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
            }
        )
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
