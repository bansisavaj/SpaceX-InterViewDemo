//
//  CompanyDescriptionCell.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import UIKit

class CompanyDescriptionCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func DisplayCompanyDescriptionCell(data: BaseCompanyModel) {        
        if let name = data.name,
           let founder = data.founder,
           let founded = data.founded,
           let employees = data.employees,
           let launchSites = data.launchSites,
           let valuation = data.valuation {
            
            self.lblDescription.text = "\(name) was founded by \(founder) in \(founded) it has now \(employees) employees. \(launchSites) launch sites, and is value at USD \(valuation)"
        }

    }
}
