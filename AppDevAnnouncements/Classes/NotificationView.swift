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

    /// Components
    private let notificationContainerView = UIView()
    private let topPortionView = UIView()
    private let bottomPortionView = UIView()
    private let dismissButton = UIButton()
    private let visualImageView = UIImageView()
    private let subjectLabel = UILabel()
    private let bodyTextView = UITextView()
    private let ctaButton = UIButton()

    /// Constants
    private let lightGray = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    private let darkGray = UIColor(displayP3Red: 114/255, green: 114/255, blue: 114/255, alpha: 1)

    init(
        dismissFunc: Selector,
        imageUrl: String?,
        subject: String,
        body: String,
        ctaText: String,
        actionFunc: Selector,
        target: UIViewController
    ) {
        super.init(frame: .zero)

        notificationContainerView.backgroundColor = .white
        addSubview(notificationContainerView)

        topPortionView.backgroundColor = .white
        addSubview(topPortionView)

        bottomPortionView.backgroundColor = lightGray
        addSubview(bottomPortionView)

        dismissButton.setImage(UIImage(named: "closeIcon"), for: .normal) // TODO: default image for dismissing?
        dismissButton.addTarget(target, action: dismissFunc, for: .touchUpInside)
        addSubview(dismissButton)
        
        subjectLabel.textAlignment = .center
        subjectLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        subjectLabel.text = subject
        addSubview(subjectLabel)

        if let unwrappedUrl = imageUrl {
            visualImageView.contentMode = .scaleAspectFit
            visualImageView.image = UIImage(named: unwrappedUrl)
            addSubview(visualImageView)
        }

        bodyTextView.backgroundColor = .clear
        bodyTextView.isSelectable = false
        bodyTextView.isScrollEnabled = false
        let style = NSMutableParagraphStyle()
        //style.lineSpacing = 4.5
        style.alignment = .center
        let bodyAttributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        bodyTextView.attributedText = NSAttributedString(string: body, attributes: bodyAttributes)
        addSubview(bodyTextView)

        ctaButton.setTitle(ctaText, for: .normal)
        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.addTarget(target, action: actionFunc, for: .touchUpInside)
        ctaButton.backgroundColor = darkGray
        ctaButton.layer.cornerRadius = 5
        addSubview(ctaButton)

        setupConstraints(noImage: imageUrl == nil)
    }
    
    private func setupConstraints(noImage: Bool) {
        notificationContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(noImage ? 244 : 345)
        }

        topPortionView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(noImage ? 74 : 171)
        }

        bottomPortionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.width.equalToSuperview()
            make.height.equalTo(174)
        }

        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalTo(notificationContainerView).inset(12)
            make.width.height.equalTo(12)
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(topPortionView).inset(32)
            make.leading.trailing.equalTo(topPortionView).inset(24)
            make.height.equalTo(31)
        }

        if (!noImage){
            visualImageView.snp.makeConstraints { make in
                make.top.equalTo(subjectLabel.snp.bottom).offset(12)
                make.centerX.equalTo(notificationContainerView)
                make.width.height.equalTo(80)
            }
        }

        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(bottomPortionView).inset(24)
            make.leading.trailing.equalTo(bottomPortionView).inset(16)
            //make.bottom.lessThanOrEqualTo(ctaButton.snp.top)
            make.height.equalTo(80)
        }

        ctaButton.snp.makeConstraints { make in
            make.top.equalTo(bodyTextView.snp.bottom).offset(16)
            //make.bottom.equalTo(bottomPortionView).inset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(38)
        }
    }

    private func applyNoImageConstraints(){
        topPortionView.snp.remakeConstraints { make in
            make.height.equalTo(71)
        }

        visualImageView.snp.removeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
