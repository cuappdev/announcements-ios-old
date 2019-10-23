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

    var notificationView: NotificationView!

    var visual : String?
    var subject : String?
    var body : String?
    var ctaText : String?
    var ctaAction : String?

    var presenter: UIViewController?
    weak var delegate : NotificationDelegate?

    convenience init(visual: String?, subject: String?, body: String?, ctaText: String?, ctaAction: String?, delegate: NotificationDelegate) {
        self.init(nibName:nil, bundle:nil)
        self.visual = visual
        self.subject = subject
        self.body = body
        self.ctaText = ctaText
        self.ctaAction = ctaAction
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView()
        if let unwrappedVisual = visual {
            notificationView.visualImageView.image = UIImage(named: unwrappedVisual)
        }
        if let unwrappedSubject = subject {
            notificationView.subjectLabel.text = unwrappedSubject
        }
        if let unwrappedBody = body {
            notificationView.bodyTextView.text = unwrappedBody
        }
        if let unwrappedCTAText = ctaText {
            notificationView.ctaButton.setTitle(unwrappedCTAText, for: .normal)
        }
        notificationView.dismissButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        notificationView.ctaButton.addTarget(self, action: #selector(openSite), for: .touchUpInside)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(notificationView)
        
        setupConstraints()
        presentNotification()
    }
    
    func setupConstraints(){
        notificationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(431)
            make.width.equalTo(288)
        }
    }

    func presentNotification(){
        //some backend stuff goes here later
        modalPresentationStyle = .overFullScreen
        delegate?.present(self)
    }
    
    @objc func dismissPopup(){
        dismiss(animated: true, completion: nil)
    }

    @objc func openSite(){
        // since ctaAction is currently only a URL, this is the only function it could possibly perform
        guard let unwrappedAction = ctaAction else { return }
        let url = URL(string: unwrappedAction)!
        UIApplication.shared.open(url)
    }

}
