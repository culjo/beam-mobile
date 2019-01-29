//
//  ProductsTableViewController.swift
//  beam mobile
//
//  Created by MAC on 1/26/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import NotificationBanner

//@objc(ProductsTableViewController)
class ProductsTableViewController: BaseTableViewController, OnCellButtonClicked {
    
    
    
    //var items: [Product] = [] // empty array
    
    let cellIdentifier = "cellRow"
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.displayFCMToken(notification:)), name: NSNotification.Name("FCMToken"), object: nil)
        
        
        allProductSubject.subscribe(onNext: {
            done in
            if done {
                self.tableView.reloadData()
            }
            self.stopRefereshing();
            
        }).disposed(by: disposeBag)
        
        userProductSubject.subscribe(onNext: {
            done  in
            self.checkForSubscribedProducts()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        // fetchProduct()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // self.view.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    }

    @objc func displayFCMToken(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        print("........LETs Get the FCM Token........")
        if let fcmToken = userInfo["token"] as? String {
            print("\n FCM TOKEN : \(fcmToken)")
            // self.fcmTokenMessage.text = "Received FCM token: \(fcmToken)"
            // save FCM Token
            saveToken(token: fcmToken)
        }
    }
    
    func saveToken(token: String) {
        ApiClient.saveFcmToken(userId: UserSessionManger.userId, fcmToken: token)
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                result in
                if result.success {
                    UserSessionManger.fcmToken = token
                }
            }).disposed(by: disposeBag)
    }
    
    func fetchProduct() {
        
        ApiClient.fetchProducts()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { products in
                
                // print(products)
                //self.items = products.data;
                self.tableView.reloadData()
                
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allProducts?.data.count ?? 0 // items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductTableViewCell

        // Configure the cell...
        if let productsList = allProducts?.data {
            
            cell.onCellButtonClicked = self
            cell.updateModel(with: productsList[indexPath.row])
        }
        

        return cell
    }
    
    func checkForSubscribedProducts() {
        guard let productList = allProducts?.data else { return }
        guard let favouriteList = userProducts?.data else { return }
        
        for product in productList {
            let found = favouriteList.contains { (uProduct) -> Bool in
                return uProduct.productID == product.productID
            }
            if found {
                product.isInUserFavourite = true
            } else {
                product.isInUserFavourite = false
            }
        }
    }
    
    func onCellButtonClicked(product: Product) {
        let alertController = UIAlertController(title: "Set Your Price", message: "Get notified once this product disocunt has matched your price", preferredStyle: UIAlertController.Style.alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Your Price"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            // let secondTextField = alertController.textFields![1] as UITextField
            
            if !firstTextField.text!.isEmpty {
                self.saveUserProductPrice(productId: product.productID, price: firstTextField.text!)
            } else {
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            NotificationBanner(title: "Canceled", subtitle: "You did not set your favourite purchase price", style: .warning).show()
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveUserProductPrice(productId: Int, price: String) {
        
        // UserSessionManger.userId
        ApiClient.subcribeToProduct(productId: productId, userId: UserSessionManger.userId, myPrice: price)
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { subscription in
                if subscription.success {
                    print("USER SUBSCRIBE TO PRODUCT \(productId) at \(price)")
                    NotificationBanner(title: "Purchase Price Set", subtitle: "Product Added to favourite & you will be notified once promo price matches your price. Thanks", style: .success).show()
                }
            }, onError: {
                err in
                print("FAILED TO SUBSCRIBE USERS")
                print(err)
                NotificationBanner(title: "Oops! Try Again", subtitle: "we could not set your prefered price, Please Try again!", style: .warning).show()
            }).disposed(by: disposeBag)
        
    }
    

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
    
    
    // MARK: Logic
    func stopRefereshing() {
        print("Refreshing Done...")
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: Webservice
    @objc func refreshData(_ sender: UIRefreshControl) {
        
        super.fecthAllProducts()
        super.fecthAllUserProducts()
        
        /*Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: {
            timer in self.stopRefereshing()
        })*/
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
