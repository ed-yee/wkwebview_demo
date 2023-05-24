//
//  InternetWebPage.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct InternetWebPage: View {
    let vm = BaseWebViewVM(webResource: "http://www.google.com")
    
    var body: some View {
        WebView(vm: vm)
            .padding()
    }
}

struct InternetWebPage_Previews: PreviewProvider {
    static var previews: some View {
        InternetWebPage()
    }
}
