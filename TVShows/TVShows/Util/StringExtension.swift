//
//  StringExtension.swift
//  TVShows
//
//  Created by José Damaren on 26/06/23.
//

import Foundation
import UIKit

extension String {
    func htmlToAttributedString(withSize size: Int) -> NSAttributedString? {
        do {
            guard let modifiedFontData = String(format:"<span style=\"font-family: '-apple-system', '\(UIFont.systemFont(ofSize: 12).fontName)'; font-size: \(size)\">%@</span>", self).data(using: .unicode, allowLossyConversion: true) else { return nil }

            return try NSAttributedString(
                data: modifiedFontData,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
