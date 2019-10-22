//
//  Announcement.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

struct Announcement: Codable {
    let visual : UIImage
    let title : String
    let description : String
    let ctaText : String // cta - call to action
    let ctaAction : URL // for now, one for sure example is a URL
}
