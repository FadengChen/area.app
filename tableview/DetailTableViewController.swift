//
//  DetailTableViewController.swift
//  tableview
//
//  Created by 陈发登 on 3/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    @IBOutlet weak var ratingBtn: UIButton!
    var area : AreaMO!
    @IBOutlet weak var LargeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let rating = area.rating{
        ratingBtn.setImage(UIImage(named: rating), for: .normal)
        }else{ratingBtn.setImage(UIImage(named: "rating"), for: .normal)
        }
LargeImageView.image = UIImage (data: area.image! as Data )
        self.tableView.backgroundColor = UIColor(white: 0.8, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
self.title = area.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as!DetailTableViewCell
        cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Province",comment: "text of province")
            cell.ValueLabel.text = area.province
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Area Name",comment: "text of area name")
            cell.ValueLabel.text = area.name
        case 2:
            cell.fieldLabel.text = NSLocalizedString("IsVisited",comment: "text of visited")
            cell.ValueLabel.text = area.isVisited ? NSLocalizedString("Visited",comment: "text of visited"):NSLocalizedString("Not Visited",comment: "text of not visited")
        default:
            break
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
   @IBAction func close(segue:UIStoryboardSegue) {
        let Reviewvc = segue.source as!ReviewViewController
    if let rating = Reviewvc.rating {
    self.area.rating = rating
        self.ratingBtn.setImage(UIImage(named: self.area.rating!), for: .normal)
    }
    let appDelegate = UIApplication.shared.delegate as!AppDelegate
    appDelegate.saveContext()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"
        {
        let vc = segue.destination as!mapViewController
            vc.area = self.area
        }
    }
    
}

