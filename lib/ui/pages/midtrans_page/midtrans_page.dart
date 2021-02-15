import 'package:carimakan/ui/components/bases/loading.dart';
import 'package:carimakan/utils/config.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/midtrans_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';

class MidtransPage extends StatefulWidget {
  final String redirectUrl;
  final int orderId;
  const MidtransPage({
    @required this.redirectUrl,
    this.orderId,
  });

  @override
  _MidtransPageState createState() => _MidtransPageState();
}

class _MidtransPageState extends State<MidtransPage> {
  InAppWebViewController webView;
  bool isWebviewReady;
  bool firstLoad;

  @override
  void initState() {
    super.initState();
    isWebviewReady = false;
    firstLoad = true;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MidtransViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        id: widget.orderId,
        url: widget.redirectUrl,
      ),
      viewModelBuilder: () => MidtransViewModel(),
      builder: (_, model, __) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            if (webView != null) {
              try {
                bool canGoBack = await webView.canGoBack();
                if (canGoBack) {
                  webView.goBack();
                  return false;
                }
              } catch (e) {
                print(">>> error $e");
                model.goBack(params: true);
                return true;
              }
            }
            model.goBack(params: true);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: ProjectColor.black1,
                onPressed: () async {
                  if (webView != null) {
                    try {
                      bool canGoBack = await webView.canGoBack();
                      (canGoBack)
                          ? webView.goBack()
                          : model.goBack(params: true);
                    } catch (e) {
                      print(">>> error $e");
                      model.goBack(params: true);
                    }
                  } else {
                    model.goBack(params: true);
                  }
                },
              ),
              backgroundColor: ProjectColor.white1,
              title: Text(
                "Payment",
                style: TypoStyle.titleBlack500,
              ),
              centerTitle: true,
            ),
            body: Container(
              color: ProjectColor.white1,
              child: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: isWebviewReady ? 1 : 0,
                    child: InAppWebView(
                      initialUrl: widget.redirectUrl,
                      initialHeaders: {},
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                          useShouldOverrideUrlLoading: true,
                        ),
                      ),
                      shouldOverrideUrlLoading: (controller, request) async {
                        var url = request.url;

                        if (!firstLoad) {
                          if (url.contains(callbackUrl())) {
                            model.goToAfterPaymentPage();
                            return ShouldOverrideUrlLoadingAction.CANCEL;
                          } else if (url.contains("#/404")) {
                            webView.loadUrl(
                                url:
                                    widget.redirectUrl.replaceAll("#/404", ""));
                            return ShouldOverrideUrlLoadingAction.CANCEL;
                          } else {
                            return ShouldOverrideUrlLoadingAction.ALLOW;
                          }
                        }

                        return ShouldOverrideUrlLoadingAction.ALLOW;
                      },
                      onWebViewCreated: (ctrl) {
                        webView = ctrl;
                      },
                      onLoadStart: (ctrl, String url) {},
                      onLoadStop: (ctrl, String url) {
                        try {
                          webView.injectCSSCode(
                            source: model.injectedCss,
                          );
                        } catch (e) {
                          print(">>> error $e");
                        }
                        setState(() {
                          isWebviewReady = true;
                          firstLoad = false;
                        });
                      },
                    ),
                  ),
                  if (!isWebviewReady) Center(child: Loading()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
