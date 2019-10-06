//
//  TestingViewController.swift
//  iOS Tools
//
//  Created by Gonzalo Gonzalez on 10/6/19.
//  Copyright © 2019 Gonzalo Gonzalez. All rights reserved.
//

import UIKit
import SnapKit

class TestingViewController: UIViewController {

    var popupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        popupButton = UIButton()
        popupButton.setTitle("Show Modal", for: .normal)
        popupButton.addTarget(self, action: #selector(presentModal), for: .touchUpInside)
        view.addSubview(popupButton)

        setupConstraints()
    }

    func setupConstraints(){
        popupButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(5)
            make.width.equalToSuperview().dividedBy(3)
        }
    }

    @objc func presentModal(){
        present(GivingDayViewController(), animated: true)
    }

}
