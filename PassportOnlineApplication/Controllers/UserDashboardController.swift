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
    
    @IBOutlet weak var kohaETerminitDatePicker: UIDatePicker!
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
        setupDatePicker()
    }
    func setupDatePicker() {
            // Set minimum date to today
            kohaETerminitDatePicker.minimumDate = Date()
            
            // Set maximum date to December 31, 2100
            let calendar = Calendar.current
            var components = DateComponents()
            components.year = 2100
            components.month = 12
            components.day = 31
            let maxDateTime = calendar.date(from: components)!
            kohaETerminitDatePicker.maximumDate = maxDateTime
            
            // Set initial time range for available appointments
            let min_Time = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
            let max_Time = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
            kohaETerminitDatePicker.setDate(min_Time, animated: false)
            
            // Fetch booked dates from CoreData and disable them
            let bookedDates = fetchBookedDatesFromCoreData()
            disableBookedDates(bookedDates)
    }
    func disableBookedDates(_ dates: [Date]) {
            for date in dates {
                if date >= kohaETerminitDatePicker.minimumDate! && date <= kohaETerminitDatePicker.maximumDate! {
                    kohaETerminitDatePicker.setDate(date, animated: true)
                    break
                }
            }
    }
    func datePicker(_ datePicker: UIDatePicker, shouldEnableDate date: Date) -> Bool {
            // Disable times outside the range of 8:00 AM to 4:00 PM
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour], from: date)
            if let hour = components.hour {
                return hour >= 8 && hour < 16
            }
            return false
        }
    func fetchBookedDatesFromCoreData() -> [Date] {
           var bookedDates: [Date] = []
           
           // Access CoreData context
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return bookedDates
           }
           let context = appDelegate.persistentContainer.viewContext
           
           // Fetch booked appointments from CoreData
           let fetchRequest: NSFetchRequest<Aplikimet> = Aplikimet.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "kohaETerminit >= %@", Date() as NSDate)
           do {
               let appointments = try context.fetch(fetchRequest)
               for appointment in appointments {
                   if let appointmentDate = appointment.kohaETerminit {
                       bookedDates.append(appointmentDate)
                   }
               }
           } catch {
               print("Failed to fetch booked appointments: \(error.localizedDescription)")
           }
           
           return bookedDates
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
            if let newAplikim = NSEntityDescription.insertNewObject(forEntityName: "Aplikimet", into: managedContext) as? Aplikimet{
                newAplikim.kohaEAplikimit = Date()
                if let nrPersonal = UserDefaults.standard.string(forKey: "personalNo"),let nrPersonalText = Int64(nrPersonal) {
                    newAplikim.kohaETerminit = kohaETerminitDatePicker.date
                    newAplikim.nrPersonal = nrPersonalText
                    do{
                        try managedContext.save()// Replace "Main" with the name of y
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
    func getUserData() {
        guard let personalNumber = UserDefaults.standard.string(forKey: "personalNo") else {
            Utilities.showAlert(on: self, title: "Error", message: "Something went wrong")
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            Utilities.showAlert(on: self, title: "Error", message: "Unable to fetch app delegate")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<SignUp>(entityName: "SignUp")
        fetchRequest.predicate = NSPredicate(format: "personalNumber == %@", personalNumber)
        fetchRequest.propertiesToFetch = ["personalNumber", "name", "lastName", "email", "municipality", "phoneNumber", "date"]
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            
            if let user = users.first {
                DispatchQueue.main.async {
                    self.personalNumberLbl.text = personalNumber
                    self.userNameSurname.text = "\(user.name ?? "") \(user.lastName ?? "")"
                    self.emailLbl.text = user.email
                    self.komunaLbl.text = user.municipality
                    self.phoneNoLbl.text = String(user.phoneNumber)
                    
                    if let dateString = user.date {
                        // Format the date using a DateFormatter
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        if let date = dateFormatter.date(from: dateString) {
                            // Format the date in the desired way and set it to the birthdayLbl
                            let displayFormatter = DateFormatter()
                            displayFormatter.dateFormat = "MMMM d, yyyy"
                            self.birthdayLbl.text = displayFormatter.string(from: date)
                        }
                    }
                    
                    self.makeLabelsVisible()
                }
            } else {
                Utilities.showAlert(on: self, title: "Error", message: "User not found for personal number: \(personalNumber)")
            }
        } catch {
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
    @objc func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let bookedDates = fetchBookedDatesFromCoreData()
        if bookedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) {
            // Date is booked, handle accordingly (show alert, etc.)
            // You may also choose to reset the date picker to the previous valid date
            sender.setDate(kohaETerminitDatePicker.minimumDate!, animated: true)
        }
    }

}
