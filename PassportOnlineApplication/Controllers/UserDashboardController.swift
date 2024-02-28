//
//  UserDashboard.swift
//  PassportOnlineApplication
//
//  Created by Blert  Osmani  on 27.2.24.
//

import Foundation
import UIKit
import CoreData
class UserDashboardController: UIViewController {
    
    @IBOutlet weak var komunaLbl: UILabel!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var personalNumberLbl: UILabel!
    @IBOutlet weak var userNameSurname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.setupAttributedText(to: userNameSurname)
        getUserData()
    }
    
    func getUserData(){
        guard let personalNumber = UserDefaults.standard.string(forKey: "personalNo") else{
            Utilities.showAlert(on: self,title: "Error", message: "Something went wrong")
            return
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Utilities.showAlert(on: self, title: "Error", message: "Unable to fetch app delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<SignUp>(entityName: "SignUp")
        fetchRequest.predicate = NSPredicate(format: "personalNumber == %@", personalNumber)
        fetchRequest.propertiesToFetch = ["personalNumber", "name", "lastName","email", "municipality", "phoneNumber"]
        
        do{
            let users = try managedContext.fetch(fetchRequest)
            
            if let user = users.first{
                DispatchQueue.main.async{
                    self.personalNumberLbl.text = personalNumber
                    self.userNameSurname.text = "\(user.name ?? "") \(user.lastName ?? "")"
                    self.emailLbl.text = user.email
                    self.komunaLbl.text = user.municipality
                    self.phoneNoLbl.text = String(user.phoneNumber)
                    self.makeLabelsVisible()
                }
            }
            else{
                Utilities.showAlert(on: self, title: "Error", message: "User not found for personal number: \(personalNumber)")
            }
        }catch{
            Utilities.showAlert(on: self, title: "Error", message: "Error fetching user data: \(error.localizedDescription)")
        }
        
        
        
        
        
    }
    
    func makeLabelsVisible(){
        emailLbl.isHidden = false;
        komunaLbl.isHidden = false;
        phoneNoLbl.isHidden = false;
        personalNumberLbl.isHidden = false;
        birthdayLbl.isHidden = false;
    }
    


}
