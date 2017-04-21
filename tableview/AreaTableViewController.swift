//
//  AreaTableViewController.swift
//  tableview
//
//  Created by 陈发登 on 20/3/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit
import CoreData
class AreaTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating{
    var areas: [AreaMO] = []
    var fc:NSFetchedResultsController<AreaMO>!
    var searchResults: [AreaMO] = []
    var sc:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.placeholder = NSLocalizedString("enter key words", comment: "input key words to search")
        sc.searchBar.searchBarStyle = .minimal
        tableView.tableHeaderView = sc.searchBar
tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let request: NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        let sd = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sd]
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        let context = appDelegate.persistentContainer.viewContext
     fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        do{
        try fc.performFetch()
            if let objects = fc.fetchedObjects{
            areas = objects
            }
        }catch{
        print(error)
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        if let objects = controller.fetchedObjects{
        areas = objects as! [AreaMO]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "GuiderShowed"){
        return
        }
        if let pv = storyboard?.instantiateViewController(withIdentifier: "guideController")as? guideViewController{
        present(pv, animated: true, completion: nil)
        }
    }
    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //print(indexPath.section, indexPath.row)
//        let menu = UIAlertController(title: "交互菜单", message: "您点击了第\(indexPath.row)", preferredStyle: .alert)
//        let option = UIAlertAction(title: "been there", style: .default) { (_) in
//        let cell = tableView.cellForRow(at: indexPath)as!areaTableViewCell
//            cell.heart.isHidden = false
//            self.zhuangtai[indexPath.row] = false
//        }
//       let option2 = UIAlertAction(title: "cancel", style: .cancel) { (_) in
//        let cell = tableView.cellForRow(at: indexPath)as!areaTableViewCell
//        cell.heart.isHidden = true
//        self.zhuangtai[indexPath.row] = true
//        }
//        let option1 = UIAlertAction(title: "delete", style: .destructive, handler: nil)
//         menu.addAction(option)
//        menu.addAction(option2)
//        menu.addAction(option1)
//        self.present(menu, animated: true, completion: nil)

       // tableView.deselectRow(at: indexPath, animated: true)
//    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionShare = UITableViewRowAction(style: .normal, title: NSLocalizedString("Share",  comment: "title for share action")) { (_, IndexPath) in
            let actionSheet = UIAlertController(title: NSLocalizedString("Share",  comment: "title for share action"), message: nil, preferredStyle: .actionSheet)
            let option1 = UIAlertAction(title: "QQ", style: .default, handler: nil)
            let option2 = UIAlertAction(title: "WeiBo", style: .default, handler: nil)
            let option3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            actionSheet.addAction(option1)
            actionSheet.addAction(option2)
            actionSheet.addAction(option3)
            self.present(actionSheet, animated: true, completion: nil)}
        actionShare.backgroundColor = UIColor.orange
           let actionDelete = UITableViewRowAction(style: .destructive, title: NSLocalizedString("Delete", bundle: Bundle(for: UIButton.classForCoder()), comment: "title for delete action"), handler: { (_, IndexPath) in
            //self.areas.remove(at: indexPath.row)
           
            let appDelegate = UIApplication.shared.delegate as!AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
           // tableView.deleteRows(at: [indexPath], with: .automatic)
           })
        
         return [actionShare, actionDelete]
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      
        return sc.isActive ? searchResults.count : areas.count
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        self.areas.remove(at: indexPath.row)
            print(self.areas.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let area = sc.isActive ? searchResults[indexPath.row] : areas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as!areaTableViewCell
cell.name.text=area.name
        cell.province.text = area.province
        cell.tupian.image = UIImage(data: area.image! as Data)
        cell.tupian.layer.cornerRadius = cell.tupian.frame.size.height/2
        cell.tupian .clipsToBounds = true
        //cell.heart.image = UIImage(named: "heart images")
       // cell.heart.isHidden = areas[indexPath.row].isVisited
        return cell
    }
    override var prefersStatusBarHidden: Bool{
    return true}

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.isActive
    }

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
    func searchFilter(text: String){
    searchResults = areas.filter({ (area) -> Bool in

        return area.name!.localizedCaseInsensitiveContains(text)||area.province!.localizedCaseInsensitiveContains(text)
    })
    }
    func updateSearchResults(for searchController: UISearchController){
        if var text = searchController.searchBar.text{
            text = text.trimmingCharacters(in: .whitespaces)
        searchFilter(text: text)
        tableView.reloadData()
        }
    
}


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let dest = segue.destination as! DetailTableViewController
            dest.area = sc.isActive ? searchResults[tableView.indexPathForSelectedRow!.row] : areas[tableView.indexPathForSelectedRow!.row]
        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue){
    }
}
