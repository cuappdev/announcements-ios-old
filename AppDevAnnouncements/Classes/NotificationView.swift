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
    private let topPortionView = UIView()
    private let bottomPortionView = UIView()
    private let dismissButton = UIButton()
    private let visualImageView = UIImageView()
    private let subjectLabel = UILabel()
    private let bodyTextView = UILabel()
    private let ctaButton = UIButton()

    /// Constants
    enum Constants {
        ///Colors
        static let lightGray = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        static let darkGray = UIColor(displayP3Red: 114/255, green: 114/255, blue: 114/255, alpha: 1)
        ///Constraints
        static let baseTopPortionViewHeight: CGFloat = 74
        static let extraImageHeight: CGFloat = 97
        static let dismissButtonPadding: CGFloat = 12
        static let dismissButtonLength: CGFloat = 12
        static let subjectLabelTopPadding: CGFloat = 32
        static let subjectLabelHorizontalPadding: CGFloat = 24
        static let subjectLabelHeight: CGFloat = 31
        static let imageViewLength: CGFloat = 80
        static let imageViewVerticalPadding: CGFloat = 16
        static let bodyTextViewTopPadding: CGFloat = 24
        static let bodyTextViewHorizontalPadding: CGFloat = 16
        static let ctaButtonTopPadding: CGFloat = 16
        static let ctaButtonHorizontalPadding: CGFloat = 24
        static let ctaButtonHeight: CGFloat = 38
        static let ctaButtonBottomPadding: CGFloat = 16
    }

    init(
        announcement: Announcement,
        dismissFunc: Selector,
        actionFunc: Selector,
        target: UIViewController
    ) {
        super.init(frame: .zero)

        topPortionView.backgroundColor = .white
        addSubview(topPortionView)

        bottomPortionView.backgroundColor = Constants.lightGray
        addSubview(bottomPortionView)

        dismissButton.setImage(UIImage(named: "closeIcon"), for: .normal)
        dismissButton.addTarget(target, action: dismissFunc, for: .touchUpInside)
        addSubview(dismissButton)

        subjectLabel.textAlignment = .center
        subjectLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        subjectLabel.text = announcement.subject
        addSubview(subjectLabel)

        if let unwrappedUrl = announcement.imageUrl {
            visualImageView.contentMode = .scaleAspectFit
            visualImageView.image = UIImage(named: unwrappedUrl)
            addSubview(visualImageView)
        }

        bodyTextView.numberOfLines = 0
        bodyTextView.backgroundColor = .clear
        bodyTextView.attributedText = Utils.attributedString(for: announcement.body)
        addSubview(bodyTextView)

        ctaButton.setTitle(announcement.ctaText, for: .normal)
        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.addTarget(target, action: actionFunc, for: .touchUpInside)
        ctaButton.backgroundColor = Constants.darkGray
        ctaButton.layer.cornerRadius = 5
        addSubview(ctaButton)

        setupConstraints(announcement: announcement)
    }

    private func setupConstraints(announcement: Announcement) {

        topPortionView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(announcement.topPortionViewHeight)
        }

        bottomPortionView.snp.makeConstraints { make in
            make.top.equalTo(topPortionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(Constants.dismissButtonPadding)
            make.width.height.equalTo(Constants.dismissButtonLength)
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(topPortionView).inset(Constants.subjectLabelTopPadding)
            make.leading.trailing.equalTo(topPortionView).inset(Constants.subjectLabelHorizontalPadding)
            make.height.equalTo(Constants.subjectLabelHeight)
        }

        if (announcement.imageUrl != nil){
            visualImageView.snp.makeConstraints { make in
                make.top.equalTo(subjectLabel.snp.bottom).offset(Constants.imageViewVerticalPadding)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(Constants.imageViewLength)
            }
        }

        bodyTextView.snp.makeConstraints { make in
            make.top.equalTo(bottomPortionView).inset(Constants.bodyTextViewTopPadding)
            make.leading.trailing.equalTo(bottomPortionView).inset(Constants.bodyTextViewHorizontalPadding)
            make.height.equalTo(announcement.bodyTextViewHeight)
        }

        ctaButton.snp.makeConstraints { make in
            make.top.equalTo(bodyTextView.snp.bottom).offset(Constants.ctaButtonTopPadding)
            make.leading.trailing.equalToSuperview().inset(Constants.ctaButtonHorizontalPadding)
            make.height.equalTo(Constants.ctaButtonHeight)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
