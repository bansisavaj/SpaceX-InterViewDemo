//
//  LaunchesCell.swift
//  SpaceXDemo
//
//  Created by Bansi on 21/12/22.
//

import UIKit
import SDWebImage

class LaunchesCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewLogoBG: UIView!
    
    @IBOutlet weak var lblStatusTitle: UILabel!
    @IBOutlet weak var viewStatusBG: UIView!
    
    @IBOutlet weak var lblMissionName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblNameType: UILabel!
    @IBOutlet weak var lblLaunchDate: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.viewBG.createCardShape()
//            self.viewLogoBG.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
            self.viewStatusBG.roundCorner()

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func DisplayLaunchesCell(arr: [BaseLaunchesModel], indexPath: IndexPath) {
        let dict = arr[indexPath.row]
        
        self.lblMissionName.text = dict.name
        
        if let url = dict.links?.patch?.large {
            self.imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.imgView.sd_setImage(with: URL(string: url), completed: nil)
            
        } else {
            self.imgView.image = UIImage()
        }
        
        if let success = dict.success {
            self.status(isSuccess: success)
        } else {
            self.viewStatusBG.isHidden = true

        }
        
        if let dateLocal = dict.dateUTC?.toDate(current: DateFormatterHandler.localDateFormat) {
            if let yyDate = ApiUtillity.shared.utcToLocal(timeString: dict.dateUTC ?? "")?.changeDateFormate(current: DateFormatterHandler.localDateFormat, need: DateFormatterHandler.yearDateFormat) {
                
                if ApiUtillity.shared.getCurrentYear() == yyDate {
                    self.lblLaunchDate.text = "This year"
                } else {
                    if Date() < dateLocal  {
                        self.lblLaunchDate.text = "From \(yyDate)"
                    } else {
                        self.lblLaunchDate.text = "Since \(yyDate)"
                    }
                }
                
            } else {
                self.lblLaunchDate.text = ""
            }
        }
        if let staticFireDateUTC = dict.staticFireDateUTC {
            if let date = ApiUtillity.shared.utcToLocal(timeString: staticFireDateUTC)?.changeDateFormate(current: DateFormatterHandler.localDateFormat, need: DateFormatterHandler.ddMMYYYYFormate) {
                self.lblDateTime.isHidden = false
                self.lblDateTime.text = date
            }
        } else {
            self.lblDateTime.isHidden = true
        }
        
        self.lblNameType.text = dict.details
    }
    func status(isSuccess: Bool) {
        self.viewStatusBG.isHidden = false
        if isSuccess {
            self.viewStatusBG.backgroundColor = setColor(color: .StatusSuccessColor)
            self.lblStatusTitle.textColor = setColor(color: .ThemeLightColor)
            self.lblStatusTitle.text = "Success"
        } else {
            self.viewStatusBG.backgroundColor = setColor(color: .ThemeDarkColor_5)
            self.lblStatusTitle.textColor = setColor(color: .ThemeDarkColor_40)
            self.lblStatusTitle.text = "Failed"
        }
    }
}
