//
//  JavascriptDialogs.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct JavascriptDialogs: View {
    @ObservedObject var vm = LocalWebViewVM(webResource: "index.html")
    
    var body: some View {
        WebView(vm: vm)
            .padding()
    }
}

struct JavascriptDialogs_Previews: PreviewProvider {
    static var previews: some View {
        JavascriptDialogs()
    }
}
