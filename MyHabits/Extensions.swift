//
//  Extensions.swift
//  MyHabits
//
//  Created by mitr on 04.04.2022.
//
import Foundation
import UIKit

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <meta charset="UTF-8">
            <style>
                body {font-family: -apple-system;}
                h2 {font-size: 20px;}
                p {font-size: 17px;}
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}



extension UIView {
    static var identifier: String {
        String(describing: self)
    }
}
