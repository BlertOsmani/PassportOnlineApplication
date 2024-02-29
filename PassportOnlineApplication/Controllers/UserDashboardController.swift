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
    func aplikoLogic(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Utilities.showAlert(on: self, title: "Error", message: "Unable to fetch app delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Aplikimet> = Aplikimet.fetchRequest()
        do{
            let appointments = try managedContext.fetch(fetchRequest)
            var kohaETerminit = Date()

            // Define start and end time for appointments
            let startOfDay = Calendar.current.date(bySettingHour: 8, minute: 30, second: 0, of: Date())!
            let endOfDay = Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!

            // Check if there are any appointments today
            if let lastAppointment = appointments.last {
                // Check if last appointment is within the same day
                if Calendar.current.isDateInToday(lastAppointment.kohaETerminit!) {
                    // Check if we've reached the end of the day
                    if lastAppointment.kohaETerminit! > endOfDay {
                        // Move to next day's start time
                        kohaETerminit = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
                    } else {
                        // Calculate the number of appointments scheduled for today
                        let numberOfAppointments = appointments.filter { Calendar.current.isDate($0.kohaETerminit!, inSameDayAs: lastAppointment.kohaETerminit!) }.count
                        
                        // Check if the number of appointments is a multiple of 5
                        if numberOfAppointments % 5 == 0 {
                            // Schedule the appointment with a 10-minute gap
                            let tenMinutesLater = Calendar.current.date(byAdding: .minute, value: 30, to: lastAppointment.kohaETerminit!)!
                            kohaETerminit = tenMinutesLater
                        } else {
                            // Schedule the appointment without a gap
                            kohaETerminit = lastAppointment.kohaETerminit!
                        }
                    }
                } else {
                    // It's a new day, start from the beginning
                    kohaETerminit = startOfDay
                }
            } else {
                // No appointments yet, start from the beginning of the day
                kohaETerminit = startOfDay
            }

            // If the appointment time exceeds the end of the day, move to the next day's start time
            if kohaETerminit > endOfDay {
                kohaETerminit = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
            }


            
            if let newAplikim = NSEntityDescription.insertNewObject(forEntityName: "Aplikimet", into: managedContext) as? Aplikimet{
                newAplikim.kohaEAplikimit = Date()
                if let nrPersonal = UserDefaults.standard.string(forKey: "personalNo"),let nrPersonalText = Int64(nrPersonal) {
                    newAplikim.kohaETerminit = kohaETerminit
                    newAplikim.nrPersonal = nrPersonalText
                    do{
                        try managedContext.save()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with the name of your storyboard
                            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "TerminiScene") as? AppointmentController
                        navigationController?.pushViewController(destinationViewController!, animated: true)
                        UserDefaults.standard.set(kohaETerminit, forKey: "kohaETerminit")
                    }catch let error as NSError{
                        Utilities.showAlert(on: self, title: "Error", message: "Something went wrong. Try again!")
                    }
                    
                }
            }
        }catch{
            Utilities.showAlert(on: self, title: "Error", message: "Error fetching the data")
        }
    }
    
    @IBAction func apliko(_ sender: Any) {
        do{
            aplikoLogic()
        }catch{
            Utilities.showAlert(on: self, title: "Error", message: "Something went wrong")
        }
        
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
