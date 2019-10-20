//
//  NotificationViewController.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 3/11/19.
//  Copyright © 2019 CUAppDev. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    var notificationView: NotificationView!

    var ctaAction: URL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        notificationView = NotificationView()
        notificationView.dismissButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        notificationView.ctaButton.addTarget(self, action: #selector(openDonateSite), for: .touchUpInside)
        notificationView.layer.cornerRadius = 10
        notificationView.clipsToBounds = true
        view.addSubview(givingDayPopupView)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        notificationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(431)
            make.width.equalTo(288)
        }
    }
    
    @objc func dismissPopup(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func openDonateSite(){
        guard let url = ctaAction/*URL(string: "https://givingday.cornell.edu/campaigns/cu-app-development")*/ else { return }
        UIApplication.shared.open(url)
    }

}
