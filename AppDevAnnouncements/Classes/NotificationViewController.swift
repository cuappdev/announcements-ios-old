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

    private var visualUrl : String!
    private var subject : String!
    private var body : String!
    private var ctaText : String!
    private var ctaAction : String!
    private var delegate : NotificationDelegate!

    convenience init(visualUrl: String, subject: String, body: String, ctaText: String, ctaAction: String, delegate: NotificationDelegate) {
        self.init()
        self.visualUrl = visualUrl
        self.subject = subject
        self.body = body
        self.ctaText = ctaText
        self.ctaAction = ctaAction
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView(dismissFunc: #selector(dismissPopup), visualUrl: visualUrl, subject: subject, body: body, ctaText: ctaText, actionFunc: #selector(openSite), target: self)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(notificationView)
        
        setupConstraints()
        presentNotification()
    }
    
    private func setupConstraints(){
        notificationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(431)
            make.width.equalTo(288)
        }
    }

    private func presentNotification(){
        //some backend stuff goes here later
        modalPresentationStyle = .overFullScreen
        delegate.present(self)
    }
    
    @objc private func dismissPopup(){
        dismiss(animated: true, completion: nil)
    }

    @objc private func openSite(){
        // since ctaAction is currently only a URL, this is the only function it could possibly perform
        let url = URL(string: ctaAction)!
        UIApplication.shared.open(url)
    }

}
