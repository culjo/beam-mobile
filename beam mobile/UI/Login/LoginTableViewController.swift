//
//  LoginTableViewController.swift
//  beam mobile
//
//  Created by MAC on 1/27/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import RxSwift
import SwiftValidator
import JGProgressHUD

class LoginTableViewController: UITableViewController, ValidationDelegate {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    let validator = Validator()
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()

        loginButton.layer.cornerRadius = 4.0
        
        validator.registerField(phoneTextField, rules: [RequiredRule()])
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        validator.validate(self)
    }
    
    func logUserIn() {
        
        ApiClient.login(phone: phoneTextField.text!, uuid: (UIDevice.current.identifierForVendor?.uuidString)!)
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { userResponse in
                
               self.dismissLoading(hud: self.hud)
                if (userResponse.success) {
                    self.hapticSuccess()
                    
                    self.saveUserDefaults(user: userResponse.data)
                    
                    if let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBarController") as? UITabBarController {
                        
                        self.present(homeController, animated: true, completion: nil)
                        
                    }
                    
                    
                } else {
                    self.hapticError()
                }
                
            }, onError: { err in
                self.hapticError()
                self.dismissLoading(hud: self.hud)
                
                self.showAlert(title: "Login Failed", message: "There was an issue login you please retry", positiveBtn: "Retry", onPositiveClick: {
                    
                })
                
            }).disposed(by: disposeBag)
        
    }
    
    
    /**
     * Persist a user session for his login attributes
     */
    func saveUserDefaults(user: User) {
        
        UserSessionManger.userId = user.userID
        UserSessionManger.phone = user.phone // phoneTextField.text!
        UserSessionManger.uuid = user.uniqueID // UIDevice.current.identifierForVendor?.uuidString)!
        UserSessionManger.isLoggedIn = true
        
    }
    
    
    func validationSuccessful() {
        showLoading(hud: hud)
        
        logUserIn()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        hapticError()
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            // error.errorLabel?.text = error.errorMessage // works if you added labels
            // error.errorLabel?.isHidden = false
        }
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
