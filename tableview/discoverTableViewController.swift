//
//  discoverTableViewController.swift
//  tableview
//
//  Created by 陈发登 on 16/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class discoverTableViewController: UITableViewController {
    @IBOutlet var spinner: UIActivityIndicatorView!
    var areas: [AVObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        getDataFromCloud()
        spinner.center = view.center
        view.addSubview(spinner)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func refresh() {
        getDataFromCloud(needUpdate: true)
    }
    func getDataFromCloud(needUpdate: Bool = false) {
        let query = AVQuery(className: "Area")
        query.order(byDescending: "createdAt")
        if needUpdate{
            query.cachePolicy = .ignoreCache
        }
        else{        query.cachePolicy = .cacheElseNetwork
            query.maxCacheAge = 120
            if query.hasCachedResult(){
                print("有缓存")
            }
        }

        query.findObjectsInBackground({(results, error) in
            if let results = results {
            self.areas = results as! [AVObject]
                OperationQueue.main.addOperation {
                    self.refreshControl?.endRefreshing()
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                    
                }
            }else{
            print(error ?? "取回错误")
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
let area = areas[indexPath.row]
        cell.textLabel?.text = area["name"] as? String
        cell.imageView?.image = #imageLiteral(resourceName: "photoalbum")
        if let imgFile = area["image"] as? AVFile{
            imgFile.getDataInBackground({ (data, error) in
                if let data = data{
                    OperationQueue.main.addOperation {
                        cell.imageView?.image = UIImage(data: data)
                    }
              
                }else{
                print(error ?? "下载图片错误")
                }
            })
            
            
        }

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
