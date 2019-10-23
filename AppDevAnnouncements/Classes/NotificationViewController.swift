//
//  NotificationViewController.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 3/11/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

protocol NotificationDelegate: class {
    func present(_ notificationViewController: NotificationViewController)
}

class NotificationViewController: UIViewController {

    private var notificationView: NotificationView!

    private var imageUrl : String!
    private var subject : String!
    private var body : String!
    private var ctaText : String!
    private var ctaAction : String!
    private var delegate : NotificationDelegate!

    init(imageUrl: String, subject: String, body: String, ctaText: String, ctaAction: String, delegate: NotificationDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.imageUrl = imageUrl
        self.subject = subject
        self.body = body
        self.ctaText = ctaText
        self.ctaAction = ctaAction
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView(dismissFunc: #selector(dismissNotification), imageUrl: imageUrl, subject: subject, body: body, ctaText: ctaText, actionFunc: #selector(performCTA), target: self)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(notificationView)
        
        setupConstraints()
        presentNotification()
    }
    
    private func setupConstraints() {
        notificationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(431)
            make.width.equalTo(288)
        }
    }

    private func presentNotification() {
        // TODO: Add backend logic later on
        modalPresentationStyle = .overFullScreen
        delegate.present(self)
    }
    
    @objc private func dismissNotification() {
        dismiss(animated: true, completion: nil)
    }

    /// Executes the CTA. The currently supported CTAs are:
    /// - URLs
    @objc private func performCTA() {
        let url = URL(string: ctaAction)!
        UIApplication.shared.open(url)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
