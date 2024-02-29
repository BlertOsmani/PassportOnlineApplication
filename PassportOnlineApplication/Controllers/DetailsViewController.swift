//
//  DetailsViewController.swift
//  PassportOnlineApplication
//
//  Created by Albert Z on 29.2.24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var user: SignUp?

    @IBOutlet weak var nrPersonal: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var lastNameLbl: UILabel!
    
    @IBOutlet weak var municipalityLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    @IBOutlet weak var dateOfBirth: UILabel!
    
    @IBOutlet weak var appoitmentLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            nrPersonal.text = String(user.personalNumber)
            nameLbl.text = (user.name ?? "N/A")
            lastNameLbl.text = (user.lastName ?? "N/A")
            municipalityLbl.text = (user.municipality ?? "N/A")
            emailLbl.text = (user.email ?? "N/A")
            phoneNumberLbl.text = String(user.phoneNumber)
            dateOfBirth.text = (user.date ?? "N/A")
                    // Add similar lines for other user details
        }
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
