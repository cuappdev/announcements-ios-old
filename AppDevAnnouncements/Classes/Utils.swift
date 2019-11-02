//
//  Utils.swift
//  TestEnv
//
//  Created by Kevin Chan on 10/27/19.
//  Copyright © 2019 Gonzalo Gonzalez. All rights reserved.
//

import UIKit

class Utils {

    internal static func getTextHeight(for attributedString: NSAttributedString, withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = attributedString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,  context: nil)

        return ceil(boundingBox.height)
    }

    internal static func attributedString(for string: String) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let bodyAttributes = [
            NSAttributedString.Key.paragraphStyle : style,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedStr = NSAttributedString(string: string, attributes: bodyAttributes)
        return attributedStr
    }

}
