//
//  PagesaController.swift
//  PassportOnlineApplication
//
//  Created by Albert Z on 28.2.24.
//

import Foundation
import UIKit

class PagesaController: UIViewController {

    @IBOutlet weak var cardCvv: UITextField!
    @IBOutlet weak var cardDate: UITextField!
    @IBOutlet weak var cardHolder: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.applyCornerRadius(to: cardCvv);
        Utilities.applyCornerRadius(to: cardDate);
        Utilities.applyCornerRadius(to: cardHolder);
        Utilities.applyCornerRadius(to: cardNumber);
        // Do any additional setup after loading the view.
    }
    


}
