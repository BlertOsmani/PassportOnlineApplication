//
//  AdminViewController.swift
//  PassportOnlineApplication
//
//  Created by Albert Z on 28.2.24.
//

import UIKit
import CoreData

class AdminProfileViewController: UIViewController {
    
    
    @IBOutlet weak var personalNumberLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var lastNameLbl: UILabel!
    
    @IBOutlet weak var municipalityLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var dateOfBirthLbl: UILabel!
    
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
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
                    self.emailLbl.text = user.email
                    self.municipalityLbl.text = user.municipality
                    self.phoneNumberLbl.text = String(user.phoneNumber)
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
        municipalityLbl.isHidden = false;
        phoneNumberLbl.isHidden = false;
        personalNumberLbl.isHidden = false;
        dateOfBirthLbl.isHidden = false;
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
