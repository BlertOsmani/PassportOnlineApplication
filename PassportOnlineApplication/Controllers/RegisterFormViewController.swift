//
//  RegisterFormViewController.swift
//  PassportOnlineAppliction
//
//  Created by Albert Z on 24.2.24.
//

import UIKit
import CoreData

class RegisterFormViewController: UIViewController {

    @IBOutlet weak var nrPersonalTextField: UITextField!
    
    @IBOutlet weak var nameTextFiel: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var municipalityTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
    }
    
    func createUser(personalNumber: Int64 ,name: String, lastName: String, password: String, email: String, phoneNumber: Int64, municipality: String){
         
        let newUser = SignUp(context: context)
        newUser.personalNumber = personalNumber
        newUser.name = name
        newUser.lastName = lastName
        newUser.password = password
        newUser.email = email
        newUser.phoneNumber = phoneNumber
        newUser.municipality = municipality
        
        do{
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signUpClick(_ sender: Any) {
        
        guard let personalNumber = Int64(nrPersonalTextField.text ?? ""),
              let name = nameTextFiel.text,
              let lastName = lastNameTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              let email = emailTextField.text,
              let phoneNumber = Int64(phoneNumberTextField.text ?? ""),
              let municipality = municipalityTextField.text else {
            showError(message: "Please fill in all fields")
            return
        }
        
        guard password == confirmPassword else {
                    showError(message: "Passwords do not match")
                    return
        }
        
        createUser(personalNumber: personalNumber, name: name, lastName: lastName, password: password, email: email, phoneNumber: phoneNumber, municipality: municipality)

        resetFields()
        showSuccess(message: "Sign up successful!")
    }
    
    func showError(message: String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
    
    func showSuccess(message: String) {
           errorLabel.text = message
           errorLabel.alpha = 1
           DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               self.errorLabel.alpha = 0
           }
       }
    
    func resetFields() {
            nrPersonalTextField.text = ""
            nameTextFiel.text = ""
            lastNameTextField.text = ""
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            datePicker.date = Date()
            emailTextField.text = ""
            phoneNumberTextField.text = ""
            municipalityTextField.text = ""
        }
    
    
    

}
