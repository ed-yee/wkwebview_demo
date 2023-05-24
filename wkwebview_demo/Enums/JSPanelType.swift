//
//  JSPanelType.swift
//  wkwebview_demo
//
//  Created by Edward Yee on 5/16/23.
//

import Foundation

enum JSPanelType {
    case alert
    case confirm
    case prompt
    
    var description: String {
        switch self {
        case .alert:
            return "Alert"
        case .confirm:
            return "Confirm"
        case .prompt:
            return "Prompt"
        }
    }
}
