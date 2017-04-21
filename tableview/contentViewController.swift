//
//  contentViewController.swift
//  tableview
//
//  Created by 陈发登 on 15/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class contentViewController: UIViewController {
    var index = 0
    var heading = ""
    var footer = ""
    var imageView = ""
    
    @IBOutlet weak var btnEnter: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var guideImageView: UIImageView!
    @IBOutlet weak var footerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = heading
        footerLabel.text = footer
        guideImageView.image = UIImage(named: imageView)
        pageControl.currentPage = index
        btnEnter.isHidden = (index != 2)
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "GuiderShowed")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
