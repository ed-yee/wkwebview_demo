//
//  LocalWebPage.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct LocalWebPage: View {
    let vm = LocalWebViewVM(webResource: "userGuide/section1/login.html")
    
    var body: some View {
        WebView(vm: vm)
            .padding()
    }
}

struct LocalWebPage_Previews: PreviewProvider {
    static var previews: some View {
        LocalWebPage()
    }
}
