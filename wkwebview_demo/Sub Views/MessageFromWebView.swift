//
//  MessageFromWebView.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct MessageFromWebView: View {
    @ObservedObject var vm = LocalWebViewVM(webResource: "index2.html")
    
    var body: some View {
        VStack(alignment: .leading) {
            WebView(vm: vm)
                .frame(height: 400)
            Text("From the web view:\n\(vm.messageFromWV)")
                .font(.system(size: 26))
            Spacer()
        }
        .padding()
    }
}

struct MessageFromWebView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFromWebView()
    }
}
