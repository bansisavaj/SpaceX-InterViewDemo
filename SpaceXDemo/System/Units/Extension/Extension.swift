//
//  Extension.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import Foundation
import UIKit

extension UIView {
    func roundCorner() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func customCorner(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func createCardShape(shadowColor: UIColor = setColor(color: .CardShadowColor), cornerRadius: Int = 10, showBorder: Bool = false) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Space X", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default) { _ in
            
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func filterActionSheet(acsTodescTitle: String, acsTodescButton: @escaping (UIAlertAction) -> Void, launchByYearTitle: String, launchByYearAction: @escaping (UIAlertAction) -> Void) {
        let actionSheet = UIAlertController(title: "Filter Launches", message: nil, preferredStyle: .actionSheet)
        let Button1 = UIAlertAction(title: acsTodescTitle, style: .default, handler: acsTodescButton)
        let Button2 = UIAlertAction(title: launchByYearTitle, style: .default, handler: launchByYearAction)
        let Button3 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        actionSheet.addAction(Button1)
        actionSheet.addAction(Button2)
        actionSheet.addAction(Button3)

        self.present(actionSheet, animated: true, completion: nil)
    }
    func launchesActionSheet(article: String, wikipedia: String, video: String) {
        let actionSheet = UIAlertController(title: "Launches", message: nil, preferredStyle: .actionSheet)
        
        let Button1 = UIAlertAction(title: "Article", style: .default) { _ in
            if let link = URL(string: article) {
              UIApplication.shared.open(link)
            }
        }
        let Button2 = UIAlertAction(title: "Wikipedia", style: .default) { _ in
            if let link = URL(string: wikipedia) {
              UIApplication.shared.open(link)
            }
        }
        let Button3 = UIAlertAction(title: "Video pages", style: .default) { _ in
            if let link = URL(string: "https://www.youtube.com/watch?v=" + video) {
              UIApplication.shared.open(link)
            }
        }
        let Button4 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        actionSheet.addAction(Button1)
        actionSheet.addAction(Button2)
        actionSheet.addAction(Button3)
        actionSheet.addAction(Button4)

        self.present(actionSheet, animated: true, completion: nil)
    }
}
extension String {
    
    func changeDateFormate(current: String, need: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = current
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = need
        
        if let dt = date{
            return  dateFormatter.string(from: dt)
        }else{
            return ""
        }
    }
    
    func toDate(current: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = current
        format.timeZone = TimeZone(identifier: "UTC")
        if let dt: Date = format.date(from: self){
            return dt
        }else{
            return Date()
        }
    }
}
