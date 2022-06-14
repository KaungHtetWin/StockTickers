//
//  UIViewAppExt.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
import UIKit
extension UIView {
    func shadowRoundCornerView() {
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.cornerRadius = 10
        clipsToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
}
