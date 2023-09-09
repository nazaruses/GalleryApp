//
//  String+Delete.swift
//  GalleryApp
//
//  Created by Nazar Dremach on 20/8/23.
//

import Foundation

extension String {
    mutating func deleteLastSymbol() {
        guard count > 0 else { return }
        
        removeLast()
    }
    
    func getConfidentString() -> String {
        guard count > 0 else { return "" }
        
        var result = String(repeating: "*", count: count)
        result.removeLast()
        let lastSymbol = String(last ?? "*")
        result.append(lastSymbol)
        
        return result
    }
}
