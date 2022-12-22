//
//  File.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import Foundation

// MARK: - Welcome
struct BaseCompanyModel: Codable {
    var headquarters: Headquarters?
    var links: Links?
    var name, founder: String?
    var founded, employees, vehicles, launchSites: Int?
    var testSites: Int?
    var ceo, cto, coo, ctoPropulsion: String?
    var valuation: Int?
    var summary, id: String?

    enum CodingKeys: String, CodingKey {
        case headquarters, links, name, founder, founded, employees, vehicles
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo, cto, coo
        case ctoPropulsion = "cto_propulsion"
        case valuation, summary, id
    }
}

// MARK: - Headquarters
struct Headquarters: Codable {
    var address, city, state: String?
}

// MARK: - Links
struct Links: Codable {
    var website, flickr, twitter, elonTwitter: String?

    enum CodingKeys: String, CodingKey {
        case website, flickr, twitter
        case elonTwitter = "elon_twitter"
    }
}
