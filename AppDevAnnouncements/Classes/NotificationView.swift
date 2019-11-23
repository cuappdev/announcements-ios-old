//
//  NotificationView.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import SnapKit

internal class NotificationView: UIView {

    /// Components
    private let topPortionView = UIView()
    private let bottomPortionView = UIView()
    private let dismissButton = UIButton()
    private let visualImageView = UIImageView()
    private let subjectLabel = UILabel()
    private let bodyLabel = UILabel()
    private let ctaButton = UIButton()

    /// Constants
    internal enum Constants {
        static let notificationViewWidth: CGFloat = 327
        static let baseTopPortionViewHeight: CGFloat = 74
        static let extraImageHeight: CGFloat = 97
        static let bodyLabelTopPadding: CGFloat = 24
        static let bodyLabelHorizontalPadding: CGFloat = 16
        static let ctaButtonTopPadding: CGFloat = 16
        static let ctaButtonHeight: CGFloat = 38
        static let ctaButtonBottomPadding: CGFloat = 16
    }
    
    internal init(
        announcement: Announcement,
        dismissFunc: Selector,
        actionFunc: Selector,
        target: UIViewController
    ) {
        super.init(frame: .zero)

        /// Colors
        let lightGray = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let darkGray = UIColor(displayP3Red: 114/255, green: 114/255, blue: 114/255, alpha: 1)

        topPortionView.backgroundColor = .white
        addSubview(topPortionView)

        bottomPortionView.backgroundColor = lightGray
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
            visualImageView.loadFrom(photoUrl: unwrappedUrl, completion: nil)
            addSubview(visualImageView)
        }

        bodyLabel.numberOfLines = 0
        bodyLabel.backgroundColor = .clear
        bodyLabel.attributedText = Utils.attributedString(for: announcement.body)
        addSubview(bodyLabel)

        ctaButton.setTitle(announcement.ctaText, for: .normal)
        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.addTarget(target, action: actionFunc, for: .touchUpInside)
        ctaButton.backgroundColor = darkGray
        ctaButton.layer.cornerRadius = 5
        addSubview(ctaButton)

        setupConstraints(announcement)
    }

    private func setupConstraints(_ announcement: Announcement) {
        let dismissButtonPadding: CGFloat = 12
        let dismissButtonLength: CGFloat = 12
        let subjectLabelTopPadding: CGFloat = 32
        let subjectLabelHorizontalPadding: CGFloat = 24
        let subjectLabelHeight: CGFloat = 31
        let imageViewLength: CGFloat = 80
        let imageViewVerticalPadding: CGFloat = 16
        let ctaButtonHorizontalPadding: CGFloat = 24

        topPortionView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(topPortionViewHeight(announcement))
        }

        bottomPortionView.snp.makeConstraints { make in
            make.top.equalTo(topPortionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(dismissButtonPadding)
            make.width.height.equalTo(dismissButtonLength)
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(topPortionView).inset(subjectLabelTopPadding)
            make.leading.trailing.equalTo(topPortionView).inset(subjectLabelHorizontalPadding)
            make.height.equalTo(subjectLabelHeight)
        }

        if (announcement.imageUrl != nil){
            visualImageView.snp.makeConstraints { make in
                make.top.equalTo(subjectLabel.snp.bottom).offset(imageViewVerticalPadding)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(imageViewLength)
            }
        }

        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomPortionView).inset(Constants.bodyLabelTopPadding)
            make.leading.trailing.equalTo(bottomPortionView).inset(Constants.bodyLabelHorizontalPadding)
            make.height.equalTo(bodyLabelHeight(announcement))
        }

        ctaButton.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(Constants.ctaButtonTopPadding)
            make.leading.trailing.equalToSuperview().inset(ctaButtonHorizontalPadding)
            make.height.equalTo(Constants.ctaButtonHeight)
        }
    }

    private func topPortionViewHeight(_ announcement: Announcement) -> CGFloat {
        return announcement.imageUrl == nil
            ? Constants.baseTopPortionViewHeight
            : Constants.baseTopPortionViewHeight + Constants.extraImageHeight
    }

    private func bodyLabelHeight(_ announcement: Announcement) -> CGFloat {
        let bodyLabelWidth = Constants.notificationViewWidth - Constants.bodyLabelHorizontalPadding * 2
        return Utils.getTextHeight(for: Utils.attributedString(for: announcement.body), withConstrainedWidth: bodyLabelWidth)
    }

    internal func getTotalHeight(_ announcement: Announcement) -> CGFloat {
        let bottomPortionViewHeight =  Constants.bodyLabelTopPadding + bodyLabelHeight(announcement) + Constants.ctaButtonTopPadding + Constants.ctaButtonHeight + Constants.ctaButtonBottomPadding
        return topPortionViewHeight(announcement) + bottomPortionViewHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
