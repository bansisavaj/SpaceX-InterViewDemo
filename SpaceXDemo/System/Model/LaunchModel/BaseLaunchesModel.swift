//
//  File.swift
//  SpaceXDemo
//
//  Created by Bansi on 22/12/22.
//

import Foundation

// MARK: - WelcomeElement
struct BaseLaunchesModel: Codable {
    var fairings: Fairings?
    var links: LaunchesLinks?
    var staticFireDateUTC: String?
    var staticFireDateUnix: Int?
    var net: Bool?
    var window: Int?
    var rocket: Rocket?
    var success: Bool?
    var failures: [Failure]?
    var details: String?
    var crew, ships, capsules, payloads: [String]?
    var launchpad: Launchpad?
    var flightNumber: Int?
    var name, dateUTC: String?
    var dateUnix: Int?
    var dateLocal: String?
    var datePrecision: DatePrecision?
    var upcoming: Bool?
    var cores: [Core]?
    var autoUpdate, tbd: Bool?
    var launchLibraryID: String?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case fairings, links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case net, window, rocket, success, failures, details, crew, ships, capsules, payloads, launchpad
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, cores
        case autoUpdate = "auto_update"
        case tbd
        case launchLibraryID = "launch_library_id"
        case id
    }
}

// MARK: - Core
struct Core: Codable {
    var core: String?
    var flight: Int?
    var gridfins, legs, reused, landingAttempt: Bool?
    var landingSuccess: Bool?
    var landingType: LandingType?
    var landpad: Landpad?

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}

enum LandingType: String, Codable {
    case asds = "ASDS"
    case ocean = "Ocean"
    case rtls = "RTLS"
}

enum Landpad: String, Codable {
    case the5E9E3032383Ecb267A34E7C7 = "5e9e3032383ecb267a34e7c7"
    case the5E9E3032383Ecb554034E7C9 = "5e9e3032383ecb554034e7c9"
    case the5E9E3032383Ecb6Bb234E7CA = "5e9e3032383ecb6bb234e7ca"
    case the5E9E3032383Ecb761634E7Cb = "5e9e3032383ecb761634e7cb"
    case the5E9E3032383Ecb90A834E7C8 = "5e9e3032383ecb90a834e7c8"
    case the5E9E3033383Ecb075134E7CD = "5e9e3033383ecb075134e7cd"
    case the5E9E3033383Ecbb9E534E7Cc = "5e9e3033383ecbb9e534e7cc"
}

enum DatePrecision: String, Codable {
    case day = "day"
    case hour = "hour"
    case month = "month"
}

// MARK: - Failure
struct Failure: Codable {
    var time: Int?
    var altitude: Int?
    var reason: String?
}

// MARK: - Fairings
struct Fairings: Codable {
    var reused, recoveryAttempt, recovered: Bool?
    var ships: [String]?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered, ships
    }
}

enum Launchpad: String, Codable {
    case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
    case the5E9E4502F509092B78566F87 = "5e9e4502f509092b78566f87"
    case the5E9E4502F509094188566F88 = "5e9e4502f509094188566f88"
    case the5E9E4502F5090995De566F86 = "5e9e4502f5090995de566f86"
}

// MARK: - Links
struct LaunchesLinks: Codable {
    var patch: Patch?
    var reddit: Reddit?
    var flickr: Flickr?
    var presskit: String?
    var webcast: String?
    var youtubeID: String?
    var article: String?
    var wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Codable {
    var small: [String]?
    var original: [String]?
}

// MARK: - Patch
struct Patch: Codable {
    var small, large: String?
}

// MARK: - Reddit
struct Reddit: Codable {
    var campaign: String?
    var launch: String?
    var media, recovery: String?
}

enum Rocket: String, Codable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}

typealias Welcome = [BaseLaunchesModel]
