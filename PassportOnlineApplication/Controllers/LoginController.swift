//
//  LoginController.swift
//  PassportOnlineAppliction
//
//  Created by Blert  Osmani  on 25.2.24.
//

import Foundation
import UIKit
import CoreData

class LoginController: UIViewController{
    
    @IBOutlet weak var errorPasswordLbl: UILabel!
    @IBOutlet weak var errorNrPersonalLbl: UILabel!
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var nrPersonal: UITextField!
    @IBOutlet weak var fjalekalimi: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad();
        Utilities.applyCornerRadius(to: nrPersonal);
        Utilities.applyCornerRadius(to: fjalekalimi);
        self.nrPersonal.addPaddingToTextField();
        self.fjalekalimi.addPaddingToTextField();
        Utilities.setupAttributedText(to: loginTitle);
        
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        guard let nrPersonalText = nrPersonal.text, !nrPersonalText.isEmpty,
//              let fjalekalimiText = fjalekalimi.text, !fjalekalimiText.isEmpty else {
//            // Show alert indicating fields are empty
//            Toast.shared.showToast(message: "Ju lutem mbushni te gjitha fushat.")
//            return
//        }
        let nrPersonalText = nrPersonal.text ?? ""
        let fjalekalimiText = fjalekalimi.text ?? ""
        if nrPersonalText.isEmpty && fjalekalimiText.isEmpty {
            Toast.shared.showToast(message: "Ju lutem mbushni te gjitha fushat.")
            errorPasswordLbl.isHidden = true
            errorNrPersonalLbl.isHidden = true
            return
        }
        else if nrPersonalText.isEmpty && !fjalekalimiText.isEmpty{
            errorNrPersonalLbl.text = "Ju lutem plotesoni nr. personal"
            errorNrPersonalLbl.isHidden = false
            errorPasswordLbl.isHidden = true
            errorNrPersonalLbl.sizeToFit()
            errorNrPersonalLbl.textColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
            return
        }
        else if !nrPersonalText.isEmpty && fjalekalimiText.isEmpty{
            errorPasswordLbl.text = "Ju lutem plotesoni fjalekalimin"
            errorNrPersonalLbl.isHidden = true
            errorPasswordLbl.isHidden = false
            errorPasswordLbl.sizeToFit()
            errorPasswordLbl.textColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
            return
        }

        if isValidLogin(nrPersonal: nrPersonalText, password: fjalekalimiText) {
            // Proceed with login
            if let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                // Assuming the view controller associated with the first tab is SceneX
                tabBarController.selectedIndex = 0
                
                // Assuming navigationController exists
                navigationController?.pushViewController(tabBarController, animated: true)
            }

            // Perform segue to next screen or any other action
        } else {
            // Show toast message indicating invalid credentials
            Toast.shared.showToast(message: "Kredencialet jane gabim.")
            errorPasswordLbl.isHidden = true
            errorNrPersonalLbl.isHidden = true
        }
    }
    func isValidLogin(nrPersonal: String, password: String) -> Bool {
            // Fetch managedObjectContext from the App Delegate
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return false
            }
            let managedContext = appDelegate.persistentContainer.viewContext

            // Prepare the fetch request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SignUp")
            fetchRequest.predicate = NSPredicate(format: "personalNumber == %@ AND password == %@", nrPersonal, password)

            do {
                // Execute the fetch request
                let result = try managedContext.fetch(fetchRequest)
                if let users = result as? [NSManagedObject], !users.isEmpty {
                    // If user is found, return true
                    return true
                }
            } catch {
                print("Error fetching user data: \(error.localizedDescription)")
            }
            // If user is not found or error occurs, return false
            return false
        }

    
    

}

