//
//  NotificationView.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import SnapKit

class NotificationView: UIView {

    // Components
    private let notificationContainerView = UIView()
    private let dismissButton = UIButton()
    private let visualImageView = UIImageView()
    private let subjectLabel = UILabel()
    private let bodyTextView = UITextView()
    private let ctaButton = UIButton()

    convenience init(dismissFunc: Selector, visualUrl: String, subject: String, body: String, ctaText: String, actionFunc: Selector, target: UIViewController) {
        self.init()
        dismissButton.addTarget(target, action: dismissFunc, for: .touchUpInside)
        visualImageView.image = UIImage(named: visualUrl)
        subjectLabel.text = subject
        bodyTextView.text = body
        ctaButton.setTitle(ctaText, for: .normal)
        ctaButton.addTarget(target, action: actionFunc, for: .touchUpInside)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        notificationContainerView.backgroundColor = .white
        addSubview(notificationContainerView)

        dismissButton.setImage(UIImage(named: "closeIcon"), for: .normal) // TODO: default image for dismissing?
        addSubview(dismissButton)

        visualImageView.contentMode = .scaleAspectFit
        addSubview(visualImageView)

        subjectLabel.numberOfLines = 0
        subjectLabel.textAlignment = .center
        subjectLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(subjectLabel)

        bodyTextView.isSelectable = false
        bodyTextView.isScrollEnabled = false
        bodyTextView.textAlignment = .center
        bodyTextView.font = UIFont.systemFont(ofSize: 13)
        addSubview(bodyTextView)

        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.backgroundColor = .red
        ctaButton.layer.cornerRadius = 5
        addSubview(ctaButton)

        setupConstraints()
    }
    
    private func setupConstraints(){
        notificationContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(431)
        }

        dismissButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(notificationContainerView).inset(12)
            make.width.height.equalTo(32)
        }

        visualImageView.snp.makeConstraints { make in
            make.top.equalTo(notificationContainerView).inset(72)
            make.leading.equalTo(notificationContainerView).inset(18)
            make.width.equalTo(252)
            make.height.equalTo(76)
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(visualImageView).inset(100)
            make.leading.trailing.equalTo(notificationContainerView).inset(70)
            make.height.equalTo(50)
        }

        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel).inset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        ctaButton.snp.makeConstraints { make in
            make.bottom.equalTo(notificationContainerView).inset(24)
            make.leading.equalToSuperview().inset(98)
            make.width.equalTo(92)
            make.height.equalTo(40)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
