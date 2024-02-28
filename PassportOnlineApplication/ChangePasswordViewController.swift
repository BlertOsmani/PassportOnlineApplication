//
//  ChangePasswordViewController.swift
//  PassportOnlineApplication
//
//  Created by Albert Z on 28.2.24.
//

import UIKit
import CoreData

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPassordTxtField: UITextField!
    
    @IBOutlet weak var confrimPasswordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        guard let newPassword = newPassordTxtField.text, !newPassword.isEmpty,
                      let confirmPassword = confrimPasswordTxtField.text, !confirmPassword.isEmpty else {
                    displayErrorAlert(message: "Please enter both new password and confirm password.")
                    return
                }

                guard newPassword == confirmPassword else {
                    displayErrorAlert(message: "New password and confirm password do not match.")
                    return
                }

                // Update password in Core Data
                if let currentUser = getCurrentUserFromCoreData() {
                    currentUser.password = newPassword

                    do {
                        try currentUser.managedObjectContext?.save()
                        displaySuccessAlert(message: "Password changed successfully.")
                    } catch {
                        displayErrorAlert(message: "Failed to update password. Please try again.")
                    }
                }
    }
    
    private func getCurrentUserFromCoreData() -> SignUp? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Utilities.showAlert(on: self, title: "Error", message: "Unable to fetch app delegate")
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
            let request: NSFetchRequest<SignUp> = SignUp.fetchRequest()

            do {
                let users = try context.fetch(request)
                return users.first
            } catch {
                return nil
            }
        }

        private func displaySuccessAlert(message: String) {
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Implement any additional actions after successful password change
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }

        private func displayErrorAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    

}
