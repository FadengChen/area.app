//
//  webViewController.swift
//  tableview
//
//  Created by 陈发登 on 16/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit
import WebKit
class webViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isHidden = true
let request = URLRequest(url: URL(string: "https://www.google.com.au/")!)
        let wkWebView = WKWebView(frame: view.frame)
        view.addSubview(wkWebView)
        wkWebView.load(request)
        wkWebView.autoresizingMask = .flexibleHeight
        //webView.loadRequest(request)
        // Do any additional setup after loading the view.
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
