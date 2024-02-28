//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    static func applyCornerRadius(to textField: UITextField){
            textField.layer.cornerRadius = 6;
            textField.layer.masksToBounds = true;
            textField.layer.borderColor = UIColor.black.cgColor;
        }
    static func setupAttributedText(to label: UILabel) {
                // Create a bold font
                let boldFont = UIFont.boldSystemFont(ofSize: label.font.pointSize)
                
                // Apply bold font to attributed text
                let attributedString = NSMutableAttributedString(string: label.text ?? "")
                attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: attributedString.length))
                
                // Set the attributed text to the label
            label.attributedText = attributedString
            label.adjustsFontSizeToFitWidth = true;
            label.numberOfLines = 0 ;
    }
    
    static func showAlert(on viewController: UIViewController, title: String, message: String) {

            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

            alert.addAction(okAction)

            viewController.present(alert, animated: true, completion: nil)

        }

        static func showAlert(on viewController: UIViewController, title: String, message: String, completion: (() -> Void)?) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in

                completion?() // Execute completion block if provided

            }

            alertController.addAction(okAction)

            viewController.present(alertController, animated: true, completion: nil)
        }
}
extension UITextField{
    func addPaddingToTextField(){
        let paddingView: UIView = UIView.init(frame: CGRect(x:0, y:0, width: 8,height:0))
        self.leftView = paddingView;
        self.leftViewMode = .always;
        self.rightView = paddingView;
        self.rightViewMode = .always;
    }
}
