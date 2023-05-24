//
//  SwiftUIWebView.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var vm: BaseWebViewVM
    init(viewModel: BaseWebViewVM) {
        self.vm = viewModel
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let userContentController = vm.webView
            .configuration
            .userContentController
        
        // Clear all message handlers, if any
        userContentController.removeAllScriptMessageHandlers()

        // Message handler without reply
        userContentController.add(context.coordinator,
                                  name: "fromWebPage")

        // Message handlers with reply
        userContentController.addScriptMessageHandler(context.coordinator,
                                                      contentWorld: WKContentWorld.page,
                                                      name: "getData")
        
        if vm.injectMessageListener {
            injectJS(userContentController)
        }

        // Handle alert
        vm.webView.uiDelegate = context.coordinator
        
        return vm.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: vm)
    }
    
    func injectJS(_ userContentController: WKUserContentController) {
        // Define message event listener.
        //
        // Note that there is no need to include the <script> HTML element
        let msgEventListener = """
window.addEventListener("message", (event) => {
    // Sanitize incoming message
    var content = event.data.replace(/</g, "&lt;").replace(/>/g, "&gt;")
    document.getElementById("message").innerHTML = content
})
"""

        // Inject event listener
        userContentController.addUserScript(WKUserScript(source: msgEventListener,
                                                         injectionTime: .atDocumentEnd,
                                                         forMainFrameOnly: false))
    }
}


extension SwiftUIWebView {
    class Coordinator: NSObject, WKUIDelegate,
                        WKScriptMessageHandler,
                        WKScriptMessageHandlerWithReply {
        var viewModel: BaseWebViewVM
        
        init(viewModel: BaseWebViewVM) {
            self.viewModel = viewModel
        }
        
        // MARK: - WKUIDelegate webView() functions
        func webView(_ webView: WKWebView,
                     runJavaScriptAlertPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping () -> Void) {
            viewModel.webPanel(message: message,
                               alertCompletionHandler: completionHandler)
        }
        
        func webView(_ webView: WKWebView,
                     runJavaScriptConfirmPanelWithMessage message: String,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (Bool) -> Void) {
            viewModel.webPanel(message: message,
                               confirmCompletionHandler: completionHandler)
        }
        
        func webView(_ webView: WKWebView,
                     runJavaScriptTextInputPanelWithPrompt prompt: String,
                     defaultText: String?,
                     initiatedByFrame frame: WKFrameInfo,
                     completionHandler: @escaping (String?) -> Void) {
            viewModel.webPanel(message: prompt,
                               promptCompletionHandler: completionHandler,
                               defaultText: defaultText)
        }

        // MARK: - WKScriptMessageHandler delegate function
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            self.viewModel.messageFrom(fromHandler: message.name,
                                       message: message.body)
        }

        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage,
                                   replyHandler: @escaping (Any?, String?) -> Void) {
            do {
                let returnValue = try self.viewModel.messageFromWithReply(fromHandler: message.name,
                                                                          message: message.body)
                
                replyHandler(returnValue, nil)
            } catch WebViewErrors.GenericError {
                replyHandler(nil, "A generic error")
            } catch WebViewErrors.ErrorWithValue(let value) {
                replyHandler(nil, "Error with value: \(value)")
            } catch {
                replyHandler(nil, error.localizedDescription)
            }
        }
    }
}
struct SwiftUIWebView_Previews: PreviewProvider {
    static let vm = LocalWebViewVM(webResource: "index.html")
    
    static var previews: some View {
        SwiftUIWebView(viewModel: vm)
            .onAppear(perform: vm.loadWebPage)
    }
}
