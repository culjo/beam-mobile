//
//  BaseTableViewController.swift
//  beam mobile
//
//  Created by MAC on 1/28/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    let userProductSubject = PublishSubject<Bool>()
    let allProductSubject = PublishSubject<Bool>()
    
    var allProducts: Products?
    var userProducts: UserProducts?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fecthAllProducts()
        self.fecthAllUserProducts()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fecthAllProducts() {
        ApiClient.fetchProducts()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { products in
                
                // print(products)
                self.allProducts = products
                self.allProductSubject.onNext(true)
                
//                self.tableView.reloadData()
                
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func fecthAllUserProducts() {
        ApiClient.fetchUserProducts()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { userProducts in
                
                // print(products)
                self.userProducts = userProducts
                self.userProductSubject.onNext(true)
                //                self.tableView.reloadData()
                
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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
