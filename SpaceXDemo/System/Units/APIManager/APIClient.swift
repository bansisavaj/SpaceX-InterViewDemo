//
//  APIClient.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import Foundation
import UIKit
import Alamofire

let IS_LOG_ENABLE = true
private let _sharedInstance = APIClient()

class APIClient {
    
    typealias apiResponseSuccess = (_ success: Data) -> Void
    typealias apiResponseError = (_ message: String) -> Void
    typealias apiResponseFailed = (_ failed: Error,_ message: String) -> Void

    class var shared: APIClient {
        return _sharedInstance
    }
    
    func authHeader() -> HTTPHeaders {
        
        var header = HTTPHeaders()
        header = ["Content-Type": "application/json",
                  "Cache-control": "no-cache",
        ]
        return header

    }

    // MARK:- GET
    func API_GET(Url:String, Params:[String : AnyObject], Progress:Bool, vc: UIViewController, completionSuccess: @escaping apiResponseSuccess, completionError: @escaping apiResponseError, completionFailed: @escaping apiResponseFailed) {
        
        if ApiUtillity.shared.isReachable() {
            
            if IS_LOG_ENABLE {
                print("URL", Url)
                print("Params", Params)
                print("Header", self.authHeader())
            }
            
            if Progress {
               ApiUtillity.shared.showhud()
            }
                        
            AF.request(Url, method: .get, parameters: Params, encoding: URLEncoding.queryString, headers: self.authHeader()).responseData { response in
                
                if Progress {
                   ApiUtillity.shared.hidehud()
                }
                switch response.result {
                case .success(let res):
                        if let statusCode = response.response?.getStatusCode() {

                        switch statusCode {
                        case 200...299:
                            do {
                                completionSuccess(res)
                                return
                            } catch _ {
                                print(String(data: res, encoding: .utf8) ?? "nothing received")
                                completionError(String(data: res, encoding: .utf8) ?? "nothing received")
                                return
                            }
                        case 401:
                            vc.showAlert(message: "status code 401")
                            return

                        case 403:
                            vc.showAlert(message: "status code 403")
                            return
                            
                        case 500:
                            vc.showAlert(message: "status code 500")
                            return
                            
                        default:
                            break
                        }
                    }
                case .failure(let error):
                    completionFailed(error, error.localizedDescription)

                }

            } .responseString { response in
                if Progress{
                    ApiUtillity.shared.hidehud()
                }
                debugPrint(response)

            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let errorTemp = NSError(domain:"Please check Internet Connection", code:12163, userInfo:nil)
                completionFailed(errorTemp, "Please check Internet Connection")
                return
            }
        }
    }
    func API_GET_ARRAY(Url:String,Params:[String : AnyObject],Progress:Bool,vc:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionError: @escaping apiResponseError,completionFailed: @escaping apiResponseFailed) {
        
        if ApiUtillity.shared.isReachable() {
            
            if IS_LOG_ENABLE{
                print("URL", Url)
                print("Params", Params)
                print("Header", self.authHeader())
            }
            
            if Progress {
                ApiUtillity.shared.showhud()
            }
            
            let authHeader = self.authHeader()
            
            AF.request(Url, method: .get, parameters: Params, encoding: URLEncoding.queryString, headers: authHeader).responseJSON { response in
                
                if Progress {
                   ApiUtillity.shared.hidehud()
                }
                switch response.result {
                case .success(_):
                        if let statusCode = response.response?.getStatusCode() {

                        switch statusCode {
                        case 200...299:
                            do {
                                if let data = response.data {
                                    completionSuccess(data)
                                }
                                return

                            } catch let error {
                                if let data = response.data {
                                    print(String(data: data, encoding: .utf8) ?? "nothing received")
                                    completionError(String(data: data, encoding: .utf8) ?? "nothing received")
                                    return
                                }
                            }
                        case 401:
                            vc.showAlert(message: "status code 401")
                            return

                        case 403:
                            vc.showAlert(message: "status code 403")
                            return
                            
                        case 500:
                            vc.showAlert(message: "status code 500")
                            return
                            
                        default:
                            break
                        }
                    }
                case .failure(let error):
                    completionFailed(error, error.localizedDescription)

                }

            } .responseString { response in
                if Progress{
                    ApiUtillity.shared.hidehud()
                }
                debugPrint(response)

            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                let errorTemp = NSError(domain:"Please check Internet Connection", code:12163, userInfo:nil)
                completionFailed(errorTemp, "Please check Internet Connection")
                return
            }
        }
    }
}
