//
//  UIApplication.swift
//  Search Up
//
//  Created by John Russo on 5/26/22.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
