//
//  UITableView.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import UIKit

extension UITableView {
    func register(_ cells: AnyClass...) {
        cells.forEach { cell in
            let id = String(describing: cell.self)
            self.register(cell, forCellReuseIdentifier: id)
        }
    }
}
