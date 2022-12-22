//
//  API.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import Foundation

public enum APIs {
    
    case company
    case launches
    
    var BaseURL: String { return APIConstant.devBaseURL}

    var path: String {
        switch self {

        case .company: return BaseURL + "company"
        case .launches: return BaseURL + "launches"
            
        }
    }
}

let WS_GET_CompanyInfo_API = APIs.company.path
let WS_GET_Launches_API = APIs.launches.path
