//
//  LocalWebViewVM.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import Foundation

class LocalWebViewVM: BaseWebViewVM {
    private func processWebResource(webResource: String) -> (inDirectory: String,
                                                             fileName: String,
                                                             fileExtension: String) {
        var wr = webResource
        
        if wr.starts(with: /\//) {
            // Remove leading "/"
            wr.remove(at: wr.startIndex)
        }
        
        if !wr.starts(with: /Web\//) {
            // Prepend "Web/"
            wr = "Web/" + wr
        }
        
        // Extract path, file name, and file extension. NSString provides
        // easier solution
        let nswr = NSString(string: wr)

        let pathName = nswr.deletingLastPathComponent
        let fileExtension = nswr.pathExtension
        let fileName = nswr.lastPathComponent.replacing(".\(fileExtension)", with: "")
        
        return (inDirectory: pathName,
                fileName: fileName,
                fileExtension: fileExtension)
    }

    override func loadWebPage() {
        if let webResource = webResource {
            let (inDirectory,
                 fileName,
                 fileExtension) = processWebResource(webResource: webResource)

            guard let filePath = Bundle.main.path(forResource: fileName,
                                                  ofType: fileExtension,
                                                  inDirectory: inDirectory) else {
                print("Bad path")
                return
            }

            print(filePath)
            let url = URL(filePath: filePath)

            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}
