//
//  MessageToWebView.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct MessageToWebView: View {
    @ObservedObject var vm = LocalWebViewVM(webResource: "index3.html")
    @State var message: String = ""
    
    init(withJSInjection: Bool = false) {
        vm.injectMessageListener = withJSInjection
        
        if withJSInjection {
            vm.webResource = "index4.html"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Message:")
                .font(.system(size: 26))
            HStack(alignment: .center, spacing: 10) {
                TextField("Enter a message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .border(.blue)
                    .font(.system(size: 26))
                Button("Send") {
                    vm.messageTo(message: message)
                }
                .buttonStyle(.borderedProminent)
            }
            WebView(vm: vm)
        }
        .padding()
    }
}

struct MessageToWebView_Previews: PreviewProvider {
    static var previews: some View {
        MessageToWebView()
        
        MessageToWebView(withJSInjection: true)
            .previewDisplayName("With JS injection")
    }
}
