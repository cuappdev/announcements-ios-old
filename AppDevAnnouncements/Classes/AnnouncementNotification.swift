//
//  Notification.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/20/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class AnnouncementNotification {

    var notificationView : NotificationView!
    var notificationViewController : NotificationViewController!

    var visual : UIImage
    var title : String
    var description : String
    var ctaText : String
    var ctaAction : URL

    init(visual: UIImage, title: String, description: String, ctaText: String, ctaAction: URL) {
        self.visual = visual
        self.title = title
        self.description = description
        self.ctaText = ctaText
        self.ctaAction = ctaAction
    }

    func getNotification() -> NotificationViewController {

        notificationView = NotificationView()
        notificationView.visual = visual
        notificationView.title = title
        notificationView.description = description
        notificationView.ctaText = ctaText

        notificationViewController = NotificationViewController()
        notificationViewController.ctaAction = ctaAction
        notificationViewController.notificationView = notificationView

        return notificationViewController
    }

}
