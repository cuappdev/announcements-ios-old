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

    static private var announcementPath: String?

    static private var isConfigSetup: Bool = false

    static private let networking: Networking = URLSession.shared.request
    
    static public func setupConfig(scheme: String, host: String, commonPath: String, announcementPath: String) {
        if(!scheme.isEmpty && !host.isEmpty && !commonPath.isEmpty && !announcementPath.isEmpty) {
            Endpoint.setupEndpointConfig(scheme, host, commonPath)
            self.announcementPath = announcementPath
            self.isConfigSetup = true
        } else {
            self.isConfigSetup = false
        }
    }

    static private func getAnnouncement() -> Future<Response>? {
        guard let unwrappedPath = announcementPath else { return nil }
        return networking(Endpoint.getAnnouncement(unwrappedPath)).decode()
    }

    static internal func retrieveAnnouncement(completion: @escaping ((Announcement?) -> Void)) {
        if isConfigSetup {
            guard let someAnnouncement = getAnnouncement() else { return }
            someAnnouncement.observe { result in
                switch result {
                case .value(let resp):
                    var announcement : Announcement?
                    if let announcementData = resp.data.first{
                        announcement = Announcement(imageUrl: announcementData.imageUrl, subject: announcementData.subject, body: announcementData.body, ctaText: announcementData.ctaText, ctaAction: announcementData.ctaAction)
                    }
                    completion(announcement)
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            print("Did not setup config properly")
        }
    }

}

internal extension UIImageView {

    func loadFrom(url: String, completion: ((Bool) -> Void)?) {
        guard let url = URL(string: url) else {
            completion?(false)
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let unwrappedData = data {
            DispatchQueue.main.async() { self.image = UIImage(data: unwrappedData) }
                completion?(true)
            } else if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
                completion?(false)
            } else {
                completion?(false)
            }
        }.resume()
    }

}
