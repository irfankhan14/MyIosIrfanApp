//
//  ViewController.swift
//  Irfan Khan S
//
//  Created by Irfan Khan on 11/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtAppName: UILabel!
    @IBOutlet weak var edtEmailAddress: CustomUITextField!
    @IBOutlet weak var edtPassword: CustomUITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initLogin()
        
    }
    
    @IBAction func onLoginSubmit(_ sender: UIButton) {
        print("On Login")
        
        if (edtEmailAddress.text == Constants.init().emailAddress && edtPassword.text == Constants.init().password){
            print("Correct Login")
        } else {
            self.showToast(message: NSLocalizedString("txt_incorrect_data", comment: ""), font: .systemFont(ofSize: 12.0))
        }
    }
    
    func initLogin() {
        txtAppName.text = NSLocalizedString("app_name", comment: "")
        edtEmailAddress.placeholder = NSLocalizedString("txt_enter_email_address", comment: "")
        edtPassword.placeholder = NSLocalizedString("txt_enter_password", comment: "")
        btnLogin.setTitle(NSLocalizedString("txt_login", comment: ""), for: .normal)
        
        
        self.edtEmailAddress.setupLeftImage(image: UIImage(systemName: "envelope")!, tintColor: UIColor.black )
        self.edtPassword.setupLeftImage(image: UIImage(systemName: "lock")!, tintColor: UIColor.black )
    }
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {

        //ToDo:: Learn Alignments
        let toastLabel = UILabel(frame: CGRect(x: 100, y: self.view.frame.size.height-100, width: 224, height: 36))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
