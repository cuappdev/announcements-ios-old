//
//  GivingDayViewController.swift
//  Eatery
//
//  Created by Gonzalo Gonzalez on 3/11/19.
//  Copyright © 2019 CUAppDev. All rights reserved.
//

// TEMPORARY TEMPLATE - WILL REMOVE

import UIKit

class GivingDayViewController: UIViewController {

    var givingDayPopupView: NotificationView!
    var blurEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        givingDayPopupView = NotificationView()
        givingDayPopupView.dismissButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        givingDayPopupView.ctaButton.addTarget(self, action: #selector(openDonateSite), for: .touchUpInside)
        //givingDayPopupView.closePopupButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        //givingDayPopupView.donateButton.addTarget(self, action: #selector(openDonateSite), for: .touchUpInside)
        givingDayPopupView.layer.cornerRadius = 10
        givingDayPopupView.clipsToBounds = true
        view.addSubview(givingDayPopupView)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        givingDayPopupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(431)
            make.width.equalTo(288)
        }
    }
    
    @objc func dismissPopup(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func openDonateSite(){
        guard let url = URL(string: "https://givingday.cornell.edu/campaigns/cu-app-development") else { return }
        UIApplication.shared.open(url)
    }

}
