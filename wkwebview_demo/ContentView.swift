//
//  ContentView.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 4/29/23.
//

import SwiftUI

struct ContentView: View {
    let title1 = "Internet Web Page"
    let title2 = "Local Web Page"
    let title3 = "Javascript Dialogs"
    let title4 = "Message from Web View"
    let title5 = "Message to Web View"
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(title1,
                               destination: InternetWebPage().navigationTitle(title1))
                NavigationLink(title2,
                               destination: LocalWebPage().navigationTitle(title2))
                NavigationLink(title3,
                               destination: JavascriptDialogs().navigationTitle(title3))
                NavigationLink(title4,
                               destination: MessageFromWebView().navigationTitle(title4))
                NavigationLink(title5,
                               destination: MessageToWebView().navigationTitle(title5))
                NavigationLink(destination: MessageToWebView(withJSInjection: true).navigationTitle(title5)) {
                    VStack(alignment: .leading) {
                        Text(title5)
                        Text("wih Javascript injection")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            .navigationTitle("Web View Demos")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
