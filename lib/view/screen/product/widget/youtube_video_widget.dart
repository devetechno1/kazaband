import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
class YoutubeVideoWidget extends StatefulWidget {
  final String? url;
  const YoutubeVideoWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<YoutubeVideoWidget> createState() => _YoutubeVideoWidgetState();
}

class _YoutubeVideoWidgetState extends State<YoutubeVideoWidget> {
  bool _isLoading = true;
  late WebViewController controllerGlobal = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          if (kDebugMode) {
            print('Page started loading: $url');
          }
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (String url) {
          if (kDebugMode) {
            print('Page finished loading: $url');
          }
          setState(() {
            _isLoading = false;
          });
        },
      ),
    )
    ..loadRequest(Uri.dataFromString('<html><body><iframe width="1920" height="1080" src="${widget.url}"  frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></body></html>', mimeType: 'text/html'));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (widget.url!.isNotEmpty &&  Uri.parse(widget.url!).hasAbsolutePath)?
    Container(height: width/1.55,width:width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: WebViewWidget(
          controller: controllerGlobal,
        ),) :
    const SizedBox.shrink();
  }
}
