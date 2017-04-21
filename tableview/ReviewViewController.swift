//
//  ReviewViewController.swift
//  tableview
//
//  Created by 陈发登 on 6/4/17.
//  Copyright © 2017 陈发登. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    var rating : String?
    @IBAction func ratingTap(_ sender: UIButton) {
        switch sender.tag {
        case 0:
        rating = "dislike"
        case 1:
            rating = "good"
        case 2:
            rating = "great"
        default:
            break
        }
        performSegue(withIdentifier: "backsegue", sender: self)
    }
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var ratingView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = view.frame
bgImageView.addSubview(effectView)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        let startPoint = CGAffineTransform(translationX: 0, y: 50)
        ratingView.transform = startScale.concatenating(startPoint)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
      UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: { 
        let endScale = CGAffineTransform.identity
        let endPoint = CGAffineTransform(translationX: 0, y: 0)
        self.ratingView.transform = endScale.concatenating(endPoint)
      }, completion: nil)


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
