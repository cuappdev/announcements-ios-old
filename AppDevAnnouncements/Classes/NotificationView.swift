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
    private let bodyLabel = UILabel()
    private let ctaButton = UIButton()
    
    init(
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
            visualImageView.image = UIImage(named: unwrappedUrl)
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

    struct Constants {
        let announcement : Announcement
        let baseTopPortionViewHeight: CGFloat = 74
        let extraImageHeight: CGFloat = 97
        let dismissButtonPadding: CGFloat = 12
        let dismissButtonLength: CGFloat = 12
        let subjectLabelTopPadding: CGFloat = 32
        let subjectLabelHorizontalPadding: CGFloat = 24
        let subjectLabelHeight: CGFloat = 31
        let imageViewLength: CGFloat = 80
        let imageViewVerticalPadding: CGFloat = 16
        let bodyLabelTopPadding: CGFloat = 24
        let bodyLabelHorizontalPadding: CGFloat = 16
        let ctaButtonTopPadding: CGFloat = 16
        let ctaButtonHorizontalPadding: CGFloat = 24
        let ctaButtonHeight: CGFloat = 38
        let ctaButtonBottomPadding: CGFloat = 16
        var topPortionViewHeight: CGFloat {
            announcement.imageUrl == nil ? baseTopPortionViewHeight: baseTopPortionViewHeight + extraImageHeight
        }
        var bodyLabelHeight: CGFloat {
            let bodyLabelWidth = NotificationViewController.Constants.notificationViewWidth - bodyLabelHorizontalPadding * 2
            return Utils.getTextHeight(for: Utils.attributedString(for: announcement.body), withConstrainedWidth: bodyLabelWidth)
        }
        var totalHeight: CGFloat {
            let bottomPortionViewHeight =  bodyLabelTopPadding + bodyLabelHeight + ctaButtonTopPadding + ctaButtonHeight + ctaButtonBottomPadding
            return topPortionViewHeight + bottomPortionViewHeight
        }
    }

    private func setupConstraints(_ announcement: Announcement) {

        let constants = Constants(announcement: announcement)

        topPortionView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(constants.topPortionViewHeight)
        }

        bottomPortionView.snp.makeConstraints { make in
            make.top.equalTo(topPortionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(constants.dismissButtonPadding)
            make.width.height.equalTo(constants.dismissButtonLength)
        }

        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(topPortionView).inset(constants.subjectLabelTopPadding)
            make.leading.trailing.equalTo(topPortionView).inset(constants.subjectLabelHorizontalPadding)
            make.height.equalTo(constants.subjectLabelHeight)
        }

        if (announcement.imageUrl != nil){
            visualImageView.snp.makeConstraints { make in
                make.top.equalTo(subjectLabel.snp.bottom).offset(constants.imageViewVerticalPadding)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(constants.imageViewLength)
            }
        }

        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomPortionView).inset(constants.bodyLabelTopPadding)
            make.leading.trailing.equalTo(bottomPortionView).inset(constants.bodyLabelHorizontalPadding)
            make.height.equalTo(constants.bodyLabelHeight)
        }

        ctaButton.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(constants.ctaButtonTopPadding)
            make.leading.trailing.equalToSuperview().inset(constants.ctaButtonHorizontalPadding)
            make.height.equalTo(constants.ctaButtonHeight)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
