import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webview extends StatefulWidget {
  const Webview({
    required this.url,
    this.appBar,
    this.onChangeUrl,
    this.showUnderNavigatorBar = false,
  });

  final String url;
  final Function(String)? onChangeUrl;
  final PreferredSizeWidget? appBar;
  final bool showUnderNavigatorBar;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final GlobalKey _webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  final InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowFileAccessFromFileURLs: true,
      allowUniversalAccessFromFileURLs: true,
      cacheEnabled: false,
      clearCache: true,
      disableContextMenu: true,
      horizontalScrollBarEnabled: false,
      verticalScrollBarEnabled: false,
      supportZoom: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController _pullToRefreshController;
  late String _title;
  int _scrollY = 0;

  void changeUrl(Uri? uri) {
    if (widget.onChangeUrl != null) {
      widget.onChangeUrl!(uri.toString());
    }
  }

  @override
  void initState() {
    _title = widget.url;
    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          //_webViewController?.reload();
          _webViewController?.loadUrl(
            urlRequest: URLRequest(url: await _webViewController?.getUrl()),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ??
          AppBar(
            title: Text(_title),
            elevation: _scrollY > 0 ? 3 : 0,
            backgroundColor: Colors.white,
          ),
      body: SafeArea(
        top: false,
        bottom: !widget.showUnderNavigatorBar,
        child: InAppWebView(
          key: _webViewKey,
          onTitleChanged: (_, String? title) {
            if (title != null) {
              setState(() => _title = title);
            }
          },
          onScrollChanged: (_, __, int? scrollY) {
            setState(() => _scrollY = scrollY ?? 0);
          },
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          initialOptions: _options,
          pullToRefreshController: _pullToRefreshController,
          onWebViewCreated: (InAppWebViewController controller) =>
              _webViewController = controller,
          onLoadStart: (InAppWebViewController controller, Uri? url) {
            changeUrl(url);
          },
          androidOnPermissionRequest: (
            InAppWebViewController controller,
            String origin,
            List<String> resources,
          ) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
          },
          onLoadStop: (InAppWebViewController controller, Uri? url) async {
            _pullToRefreshController.endRefreshing();
            changeUrl(url);
          },
          onLoadError: (
            InAppWebViewController controller,
            Uri? url,
            int code,
            String message,
          ) {
            _pullToRefreshController.endRefreshing();
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            if (progress == 100) {
              _pullToRefreshController.endRefreshing();
            }
          },
          onUpdateVisitedHistory: (
            InAppWebViewController controller,
            Uri? url,
            bool? androidIsReload,
          ) {
            changeUrl(url);
          },
          onConsoleMessage: (
            InAppWebViewController controller,
            ConsoleMessage consoleMessage,
          ) {},
        ),
      ),
    );
  }
}
