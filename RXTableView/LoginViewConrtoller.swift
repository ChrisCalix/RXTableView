//
//  LoginViewConrtoller.swift
//  RXTableView
//
//  Created by Sonic on 14/7/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewConrtoller: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        self.loginButton
            .rx
            .tap
            .withLatestFrom(Observable.combineLatest(
                usernameTextField.rx.text.orEmpty,
                passwordTextField.rx.text.orEmpty))
            .subscribe(onNext: {
                self.login(user: $0, pass: $1)
            })
            .disposed(by: bag)
    }
    
    func login(user: String, pass: String) {
        let emailRegEx = "[A-Z0-9a-z,_%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        let emailValid: Bool = emailTest.evaluate(with: user)
        let passValid: Bool = (!pass.isEmpty && pass.count >= 6)
        
        if emailValid && passValid {
            let foodListVC = self.storyboard?.instantiateViewController(withIdentifier: "FoodListVC") as! ViewController
            self.navigationController?.pushViewController(foodListVC, animated: true)
        } else {
            Utils.displaySimpleAlert(title: "Wrong Credentials", message: "Please enter a valid username and password", viewController: self)
        }
    }
}
