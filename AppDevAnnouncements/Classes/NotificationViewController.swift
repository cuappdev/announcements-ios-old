//
//  NotificationViewController.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 3/11/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

internal class NotificationViewController: UIViewController {

    /// Components
    var notificationView: NotificationView!

    /// Initializer variables
    var announcement: Announcement

    init(announcement: Announcement) {
        self.announcement = announcement
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen // Will eventually be changed to a custom presentation animation
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView(announcement: announcement, dismissFunc: #selector(dismissNotification), actionFunc: #selector(performCTA), target: self)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(notificationView)

        setupConstraints()
    }

    func setupConstraints() {
        notificationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(notificationView.getTotalHeight(announcement))
            make.width.equalTo(NotificationView.Constants.notificationViewWidth)
        }
    }

    @objc func dismissNotification() {
        dismiss(animated: true, completion: nil)
    }

    /// Executes the CTA. The currently supported CTAs are:
    /// - URLs
    @objc func performCTA() {
        guard let url = URL(string: announcement.ctaAction) else { return }
        UIApplication.shared.open(url)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UIViewController+Extension for notification presentation

public extension UIViewController {

    func presentAnnouncement(completion: @escaping (Bool) -> Void) {
        AnnouncementNetworking.retrieveAnnouncement { announcement in
            if let unwrappedAnnouncement = announcement  {
                let notification = NotificationViewController(announcement: unwrappedAnnouncement)
                DispatchQueue.main.async {
                    self.present(notification, animated: true)
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
