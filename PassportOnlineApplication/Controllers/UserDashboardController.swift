//
//  UserDashboard.swift
//  PassportOnlineApplication
//
//  Created by Blert  Osmani  on 27.2.24.
//

import Foundation
import UIKit
class UserDashboardController: UIViewController {

    @IBOutlet weak var userNameSurname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.setupAttributedText(to: userNameSurname)
        
    }


}
