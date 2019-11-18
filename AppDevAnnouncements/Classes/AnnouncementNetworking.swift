//
//  AnnouncementNetworking.swift
//  AppDevAnnouncements
//
//  Created by Gonzalo Gonzalez on 11/17/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import FutureNova

public class AnnouncementNetworking {

    private var announcementPath: String
    private var caller: UIViewController

    private let networking: Networking = URLSession.shared.request

    init(scheme: String, host: String, commonPath: String, announcementPath: String, caller: UIViewController) {
        Endpoint.setupEndpointConfig(scheme, host, commonPath)
        self.announcementPath = announcementPath
        self.caller = caller
    }

    private func getAnnouncement() -> Future<Response> {
        return networking(Endpoint.getAnnouncement(announcementPath)).decode()
    }

    public func retrieveAnnouncement() {
        getAnnouncement().observe { [weak self] result in
            switch result {
            case .value(let resp):
                let ref = resp.data
                let announcement = Announcement(imageUrl: ref.imageUrl, subject: ref.subject, body: ref.body, ctaText: ref.ctaText, ctaAction: ref.ctaAction)
                self?.caller.presentNotification(announcement: announcement)
            case .error(_):
                print("No current announcements")
            }
        }
    }
}
