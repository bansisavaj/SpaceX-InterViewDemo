//
//  ApiUtillity.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

private let _sharedInstance = ApiUtillity()

class ApiUtillity: NSObject {
    class var shared: ApiUtillity {
        return _sharedInstance
    }

    // MARK: - Check Internet Connection
    func isReachable() -> Bool
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        return (reachabilityManager?.isReachable)!
    }
    
    // MARK: - LoaderView
    func showhud() {
        let activityData = ActivityData()
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleRipple
        NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 55
        NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 55
        NVActivityIndicatorView.DEFAULT_COLOR = setColor(color: .ThemeDarkColor) //spinnerColor
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func hidehud() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func getCurrentYear() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    func utcToLocal(formate: String = DateFormatterHandler.localDateFormat, timeString: String) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        let timeUTC = dateFormatter.date(from: timeString)
        if timeUTC != nil {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.timeZone = .current //TimeZone.init(abbreviation: "UTC")
            formatter.dateFormat = formate
            let localTime = formatter.string(from: timeUTC!)
            return localTime
        }
        return ""
    }
}
