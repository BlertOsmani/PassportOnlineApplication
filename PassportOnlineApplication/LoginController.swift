//
//  LoginController.swift
//  PassportOnlineAppliction
//
//  Created by Blert  Osmani  on 25.2.24.
//

import Foundation
import UIKit

class LoginController: UIViewController{
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var nrPersonal: UITextField!
    @IBOutlet weak var fjalekalimi: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad();
        applyCornerRadius(to: nrPersonal);
        applyCornerRadius(to: fjalekalimi);
        self.nrPersonal.addPaddingToTextField();
        self.fjalekalimi.addPaddingToTextField();
        setupAttributedText();
    }
    
    private func applyCornerRadius(to textField: UITextField){
        textField.layer.cornerRadius = 6;
        textField.layer.masksToBounds = true;
        textField.layer.borderColor = UIColor.black.cgColor;
    }
    func setupAttributedText() {
            // Create a bold font
            let boldFont = UIFont.boldSystemFont(ofSize: loginTitle.font.pointSize)
            
            // Apply bold font to attributed text
            let attributedString = NSMutableAttributedString(string: loginTitle.text ?? "")
            attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: attributedString.length))
            
            // Set the attributed text to the label
            loginTitle.attributedText = attributedString
            loginTitle.adjustsFontSizeToFitWidth = true;
            loginTitle.numberOfLines = 0 ;
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
