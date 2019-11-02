//
//  NotificationViewController.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 3/11/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

public protocol NotificationDelegate: class {
    func present(_ notificationViewController: NotificationViewController)
}

public class NotificationViewController: UIViewController {

    /// Components
    private var notificationView: NotificationView!

    /// Initializer variables
    private var announcement: Announcement
    private weak var delegate : NotificationDelegate?

    public init(announcement: Announcement, delegate: NotificationDelegate) {
        self.announcement = announcement
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView(announcement: announcement, dismissFunc: #selector(dismissNotification), actionFunc: #selector(performCTA), target: self)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(notificationView)

        setupConstraints()
        presentNotification()
    }

    private func setupConstraints() {
        notificationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(notificationView.getTotalHeight(announcement))
            make.width.equalTo(NotificationView.Constants.notificationViewWidth)
        }
    }

    private func presentNotification() {
        // TODO: Add backend logic later on
        modalPresentationStyle = .overFullScreen
        delegate?.present(self)
    }

    @objc private func dismissNotification() {
        dismiss(animated: true, completion: nil)
    }

    /// Executes the CTA. The currently supported CTAs are:
    /// - URLs
    @objc private func performCTA() {
        guard let url = URL(string: announcement.ctaAction) else { return }
        UIApplication.shared.open(url)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
