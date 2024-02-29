//
//  AppointmentController.swift
//  PassportOnlineApplication
//
//  Created by Blert  Osmani  on 29.2.24.
//

import Foundation
import CoreData


import UIKit

class AppointmentController: UIViewController {
    
    @IBOutlet weak var kohaETerminitDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func fetchData() {
        kohaETerminitDatePicker.date = UserDefaults.standard.object(forKey: "kohaETerminit") as! Date

//        if let nrPersonal = UserDefaults.standard.string(forKey: "personalNo"),
//           let nrPersonalText = Int64(nrPersonal) {
//            
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return
//            }
//            
//            let managedContext = appDelegate.persistentContainer.viewContext
//            
//            // Prepare the fetch request
//            let fetchRequest: NSFetchRequest<Aplikimet> = Aplikimet.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "nrPersonal == %lld", nrPersonalText)
//            
//            do {
//                // Execute the fetch request
//                let result = try managedContext.fetch(fetchRequest)
//                if let aplikimet = result.first {
//                    // Safely unwrap kohaETerminit before using it
//                    if let kohaETerminit = aplikimet.kohaETerminit {
//                        kohaETerminitDatePicker.date = kohaETerminit
//                    } else {
//                        print("Error: KohaETerminit date is nil in the fetched record.")
//                    }
//                } else {
//                    print("Error: No records found for personal number \(nrPersonalText).")
//                }
//            } catch {
//                print("Error fetching user data: \(error.localizedDescription)")
//            }
//        }
        
        
    }
}
