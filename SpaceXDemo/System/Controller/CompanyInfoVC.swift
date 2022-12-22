//
//  ViewController.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import UIKit

struct CompanySections {
    let sectionType: CompanySectionsType
    let sectionRowCount: Int
    let headerTitle: String
}

enum CompanySectionsType {
    case CompanyInfo
    case Lunaches
}

class CompanyInfoVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var txtSeachBar: UITextField!
    @IBOutlet weak var tblView: UITableView!

    //MARK: - Variables
    var arrCompanySections = [CompanySections]()
    var companyInfo = BaseCompanyModel()
    var arrLaunch = [BaseLaunchesModel]()
    var isAccendingOrder = Bool()
    var isLaunchesbyYearAccending = Bool()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    //MARK: - IBActions
    @IBAction func btnFilterAction(_ sender: UIButton) {
        
        let ascTitle = (isAccendingOrder == false) ? "Name (ASC - DESC)" : "Name (DESC - ASC)"
        let yearTitle = (isLaunchesbyYearAccending == false) ? "Years (ASC - DESC)" : "Years (DESC - ASC)"

        self.filterActionSheet(acsTodescTitle: ascTitle, acsTodescButton: { _ in
            self.filterByName()
            
        }, launchByYearTitle: yearTitle, launchByYearAction: { _ in
            self.filterByYear()
        })
    }
    
    //MARK: - Globle Functions
    func setUpUI() {
        self.viewFilter.customCorner(radius: 5)
        self.viewSearch.createCardShape()
        self.registerCell()

        /// Api Calling
        self.getCompanyInfo()
    }
    
    func registerCell() {
        self.tblView.registerCell(type: CompanyDescriptionCell.self)
        self.tblView.registerCell(type: CompanyHeaderCell.self)
        self.tblView.registerCell(type: LaunchesCell.self)
    }
    
    func filterByYear() {
        print(self.isLaunchesbyYearAccending)

        if self.isLaunchesbyYearAccending {
            self.arrLaunch = self.arrLaunch.sorted(by: { $0.dateUTC!.compare($1.dateUTC!) == .orderedAscending } )
        } else {
            self.arrLaunch = self.arrLaunch.sorted(by: { $0.dateUTC!.compare($1.dateUTC!) == .orderedDescending } )
        }
        self.isLaunchesbyYearAccending = !self.isLaunchesbyYearAccending
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    func filterByName() {
        
        if self.isAccendingOrder {
            self.arrLaunch = self.arrLaunch.sorted(by: { ($0.name ?? "") > ($1.name ?? "") })
        } else {
            self.arrLaunch = self.arrLaunch.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
        }
        self.isAccendingOrder = !self.isAccendingOrder

        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
}
//MARK: - UITableViewDelegate
extension CompanyInfoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyHeaderCell") as! CompanyHeaderCell
        let dict = self.arrCompanySections[section]
        cell.lblTitle.text = dict.headerTitle
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.arrCompanySections[section].headerTitle.isEmpty ? .leastNonzeroMagnitude : 50
    }
}
//MARK: - UITableViewDataSource
extension CompanyInfoVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrCompanySections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCompanySections[section].sectionRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.arrCompanySections[indexPath.section].sectionType {
        case .CompanyInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyDescriptionCell") as! CompanyDescriptionCell
            cell.DisplayCompanyDescriptionCell(data: self.companyInfo)
            return cell
            
        case .Lunaches:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchesCell") as! LaunchesCell
            cell.DisplayLaunchesCell(arr: self.arrLaunch, indexPath: indexPath)
            return cell
        }
    }
}
extension CompanyInfoVC {
    
    func getCompanyInfo() {
        APIClient.shared.API_GET(Url: WS_GET_CompanyInfo_API, Params: noParams, Progress: true, vc: self, completionSuccess: { success in
            print(success)
            do {
                let data = try JSONDecoder().decode(BaseCompanyModel.self, from: success)
                self.companyInfo = data
                self.arrCompanySections.append(CompanySections(sectionType: .CompanyInfo, sectionRowCount: 1, headerTitle: "Company Info"))
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
                self.getLaunchesList()

            } catch {
                print("Having some issue with the model")
            }

        }, completionError: { message in
            print(message)
            self.showAlert(message: message)

        }, completionFailed: { failed, message in
            print(message)
            self.showAlert(message: message)

        })
    }
    
    func getLaunchesList() {
        APIClient().API_GET_ARRAY(Url: WS_GET_Launches_API, Params: noParams, Progress: true, vc: self, completionSuccess: { success in
            print(success)
            
            do {
                let data = try JSONDecoder().decode([BaseLaunchesModel].self, from: success)
                self.arrLaunch = data
                self.arrCompanySections.append(CompanySections(sectionType: .Lunaches, sectionRowCount: data.count, headerTitle: "Launches"))
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            } catch {
                print("Having some issue with the model")
            }

        }, completionError: { message in
            print(message)
            self.showAlert(message: message)

        }, completionFailed: { failed, message in
            print(message)
            self.showAlert(message: message)

        })
    }
}
