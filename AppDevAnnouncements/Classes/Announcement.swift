//
//  Announcement.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 10/16/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

struct Announcement: Codable {
    let visualUrl : String // in the form of a URL
    let subject : String
    let body : String
    let ctaText : String // cta - call to action
    let ctaAction : String // for now, one for sure example is a URL
}
