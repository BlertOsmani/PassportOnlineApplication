//
//  Toast.swift
//  PassportOnlineApplication
//
//  Created by Blert  Osmani  on 27.2.24.
//

import Foundation
import UIKit

class Toast: UIView {

    static let shared = Toast()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2 - 150, y: UIScreen.main.bounds.height-100, width: 300, height: 50))
        toastLabel.backgroundColor = UIColor(red: 235/255, green: 64/255, blue: 52/255, alpha: 1)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 17)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        UIApplication.shared.keyWindow?.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
