//
//  Announcement.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

struct Announcement: Codable {

    /// The URL of the image
    let imageUrl : String?

    /// The header title of the notification
    let subject : String

    /// The main text of the notification
    let body : String

    /// CTA - Call To Action
    let ctaText : String

    /// The only action currently supported: visiting a URL
    let ctaAction : String

    var topPortionViewHeight: CGFloat {
        imageUrl == nil ? NotificationView.Constants.baseTopPortionViewHeight
        : NotificationView.Constants.baseTopPortionViewHeight + NotificationView.Constants.extraImageHeight
    }

    var bodyTextViewHeight: CGFloat {
        let bodyTextViewWidth = NotificationViewController.Constants.notificationViewWidth - NotificationView.Constants.bodyTextViewHorizontalPadding * 2
        return Utils.getTextHeight(for: Utils.attributedString(for: body), withConstrainedWidth: bodyTextViewWidth)
    }
    
    var totalHeight: CGFloat {
        let bottomPortionViewHeight = NotificationView.Constants.bodyTextViewTopPadding + bodyTextViewHeight + NotificationView.Constants.ctaButtonTopPadding + NotificationView.Constants.ctaButtonHeight + NotificationView.Constants.ctaButtonBottomPadding
        return topPortionViewHeight + bottomPortionViewHeight
    }

}
