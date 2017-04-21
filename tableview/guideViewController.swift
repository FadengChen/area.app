//
//  guideViewController.swift
//  tableview
//
//  Created by 陈发登 on 15/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class guideViewController: UIPageViewController, UIPageViewControllerDataSource {
    var headings = ["Swift 3","ios 10",NSLocalizedString("Zero Basic",comment: "text of zero basic")]
    var images = ["swift","iOS","beginner"]
    var footers = ["Swift 3","iOS 10, learn it now","no need for previous study"]
    override func viewDidLoad() {
        super.viewDidLoad()
self.dataSource = self
        if let startVC = vc(atIndex: 0){
        setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
    var index = (viewController as!contentViewController).index
        index -= 1
        return vc(atIndex: index)
    }
    

     func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        var index = (viewController as!contentViewController).index
        index += 1
        return vc(atIndex: index)
    }
    func vc(atIndex: Int) -> contentViewController? {
        if case 0..<headings.count = atIndex{
            if let cv = storyboard?.instantiateViewController(withIdentifier: "ContentController") as? contentViewController{
        cv.heading = headings[atIndex]
        cv.footer = footers[atIndex]
        cv.imageView = images[atIndex]
        cv.index = atIndex
        return cv
            }}
        return nil
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
