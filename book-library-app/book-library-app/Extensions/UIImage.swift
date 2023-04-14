//
//  UIImage.swift
//  book-library-app
//
//  Created by Bahdan Piatrouski on 14.04.23.
//

import UIKit

extension UIImage {
    var aspectRatio: CGFloat {
        let size = self.size
        return size.height / size.width
    }
}
