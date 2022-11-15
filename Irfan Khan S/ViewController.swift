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
        if (edtEmailAddress.text == Constants.init().emailAddress && edtPassword.text == Constants.init().password){
            writeUserDefaults(emailAddress: Constants.init().emailAddress, appLoginStatus: true)
            navigateToBaseView()
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
        
        let emailAddress = UserDefaults.standard.string(forKey: Constants.init().keyEmailAddress)
        edtEmailAddress.text = emailAddress
        
        
        let appLoginStatus = UserDefaults.standard.bool(forKey:Constants.init().keyAppLoginStatus)
        if (appLoginStatus == true) {
            navigateToBaseView()
        }
    }
    
    private func navigateToBaseView() {
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        self.navigationController?.pushViewController(storyBoard, animated: true)
    }
    
    private func writeUserDefaults(emailAddress: String, appLoginStatus: Bool) {
        UserDefaults.standard.set(emailAddress, forKey: Constants.init().keyEmailAddress)
        UserDefaults.standard.set(appLoginStatus, forKey: Constants.init().keyAppLoginStatus)
    }
    
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        //ToDo:: Learn Alignments
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/4, y: self.view.frame.size.height - self.view.frame.size.height/10, width: self.view.frame.size.width/2, height: 36))
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
