//
//  NotificationView.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//

import UIKit

class NotificationView: UIView {

    var notificationContainerView: UIView!
    var dismissButton: UIButton!
    var visualImageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionTextView: UITextView!
    var ctaButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        notificationContainerView = UIView()
        notificationContainerView.backgroundColor = .white
        addSubview(notificationContainerView)

        dismissButton = UIButton()
        dismissButton.setImage(UIImage(named: "closeIcon"), for: .normal) // TODO: default image for dismissing?
        addSubview(dismissButton)

        visualImageView = UIImageView()
        visualImageView.image = UIImage(named: "givingDayApps") // TODO: Announcement.visual
        visualImageView.contentMode = .scaleAspectFit
        addSubview(visualImageView)

        titleLabel = UILabel()
        titleLabel.text = "Support Us On Giving Day 3.14"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addSubview(titleLabel)

        descriptionTextView = UITextView()
        //line spacing
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        descriptionTextView.attributedText = NSAttributedString(string: "Support Eatery by donating to Cornell AppDev! Funding will help us add new features like crowdedness, collegetown eateries, and more!", attributes: attributes)
        descriptionTextView.isSelectable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.textAlignment = .center
        descriptionTextView.font = UIFont.systemFont(ofSize: 13)
        addSubview(descriptionTextView)

        ctaButton = UIButton()
        ctaButton.setTitle("Donate", for: .normal)
        ctaButton.setTitleColor(.white, for: .normal)
        ctaButton.backgroundColor = .red
        ctaButton.layer.cornerRadius = 5
        addSubview(ctaButton)

        setupConstraints()

    }

    func setupConstraints(){
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

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(visualImageView).inset(100)
            make.leading.trailing.equalTo(notificationContainerView).inset(70)
            make.height.equalTo(50)
        }

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(62)
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
