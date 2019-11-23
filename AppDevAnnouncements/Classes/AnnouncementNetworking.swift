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
        if(scheme != "" && host != "" && commonPath != "" && announcementPath != "") {
            Endpoint.setupEndpointConfig(scheme, host, commonPath)
            self.announcementPath = announcementPath
            self.isConfigSetup = true
        } else {
            self.isConfigSetup = false
        }

    }

    static private func getAnnouncement() -> Future<Response> {
        return networking(Endpoint.getAnnouncement(announcementPath!)).decode()
    }

    static internal func retrieveAnnouncement(completion: @escaping ((Announcement?) -> Void)) {
        if isConfigSetup {
            getAnnouncement().observe { result in
                switch result {
                case .value(let resp):
                    let ref = resp.data[0]
                    let announcement = Announcement(imageUrl: ref.imageUrl, subject: ref.subject, body: ref.body, ctaText: ref.ctaText, ctaAction: ref.ctaAction)
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
    func loadFromURL(photoUrl: String, completion: @escaping ((Bool) -> Void) = {_ in}) {
        guard let url = URL(string: photoUrl) else {completion(false); return}
        let request = URLRequest(url: url)
        let session = URLSession.shared
        var successful = false
        let datatask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error = error {
                print(error.localizedDescription as Any)
            }
            if let data = data {
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
                successful = true
                }
            } else {
                successful = false
            }
            completion(successful)
        }
        datatask.resume()
    }
}
