//
//  AdminDashboardViewController.swift
//  PassportOnlineApplication
//
//  Created by Albert Z on 28.2.24.
//

import UIKit
import CoreData

class AdminDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var applicants: [SignUp] = []  // Assuming SignUp is your entity for user data

        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            fetchApplicants()
        }

        // MARK: - Table View Data Source

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return applicants.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "applicantCell", for: indexPath)
            
            // Assuming you have a 'name' attribute in your SignUp entity
            let user = applicants[indexPath.row]
            cell.textLabel?.text = user.name ?? "Name not available"
            
            return cell
        }

        // MARK: - Table View Delegate

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedUser = applicants[indexPath.row]
            showDetails(for: selectedUser)
        }

        // MARK: - Core Data

        func fetchApplicants() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                // Handle error
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<SignUp>(entityName: "SignUp")  // Assuming SignUp is your entity
            // You can add additional predicates or sort descriptors if needed

            do {
                applicants = try managedContext.fetch(fetchRequest)
                tableView.reloadData()
            } catch {
                // Handle error
            }
        }

        func showDetails(for user: SignUp) {
            // Navigate to a details view controller and pass the 'user' object for detailed information
            // You can implement navigation logic based on your application flow
            // Example: Present a new view controller with details
            let detailsVC = UIStoryboard(name: "AdminDashboard", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            detailsVC.user = user
            navigationController?.pushViewController(detailsVC, animated: true)
        }
}
