//
//  WebView.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import SwiftUI

struct WebView: View {
    @ObservedObject var vm: BaseWebViewVM
    
    var body: some View {
        SwiftUIWebView(viewModel: vm)
            .onAppear(perform: vm.loadWebPage)
            .alert(vm.panelTitle,
                   isPresented: $vm.showPanel,
                   actions: {
                switch vm.panelType {
                case .alert:
                    Button("Close") {
                        vm.alertCompletionHandler()
                    }
                case .confirm:
                    Button("Ok") {
                        vm.confirmCompletionHandler(true)
                    }
                    Button("Cancel") {
                        vm.confirmCompletionHandler(false)
                    }
                case .prompt:
                    TextField(text: $vm.promptInput) {}
                    Button("Ok") {
                        vm.promptCompletionHandler(vm.promptInput)
                    }
                    Button("Cancel") {
                        vm.promptCompletionHandler(nil)
                    }
                default:
                    Button("Close") {}
                }
            }, message: {
                Text(vm.panelMessage)
            })
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(vm: LocalWebViewVM(webResource: "index.html"))
    }
}
