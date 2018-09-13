//
//  TodayViewController.swift
//  ScorerWidget
//
//  Created by conilus on 2018/09/02.
//  Copyright © 2018年 conilus. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    let categories: [[String:Any]] = [
        ["id" : 1, "name" : "睡眠", "color" : UIColor.cyan],
        ["id" : 2, "name" : "勉強", "color" : UIColor.purple],
        ["id" : 3, "name" : "仕事", "color" : UIColor.orange],
    ]
    var modified = false;
    var current = ["score" : 4, "category_id" : 1, "started_at" : Date()] as [String : Any]
//    var current = Spending.all().last ?? Spending.create(score: 4, category_id: 1, started_at: Date())
//    var currentCategory =
    let formatter = DateComponentsFormatter()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var blackMask: UIView!
    @IBOutlet weak var whiteMask: UIView!
    
    @IBAction func switchCategory(_ sender: Any) {
        current = [
            "score" : current["score"]!,
            "category_id" : ((current["category_id"] as! Int + 1) % 3) + 1,
            "started_at" : Date()
            ]
        print("\(current)")
        updateLabels()
    }
    
    @IBAction func plus(_ sender: Any) {
        current = [
            "score" : [current["score"] as! Int + 1, 5].min()!,
            "category_id" : current["category_id"]!,
            "started_at" : Date()
        ]
        print("\(current)")
        updateLabels()
    }
    
    @IBAction func minus(_ sender: Any) {
        current = [
            "score" : [current["score"] as! Int - 1, 1].max()!,
            "category_id" : current["category_id"]!,
            "started_at" : Date()
        ]
        print("\(current)")
        updateLabels()
    }
    
    func currentCategory() -> [String:Any] {
        return categories.filter { $0["id"] as! Int == current["category_id"] as! Int }.first!
    }
    
    func updateLabels() {
        self.view.backgroundColor = (currentCategory()["color"] as! UIColor)
        blackMask.alpha = CGFloat(4 - (current["score"] as! Int)) * 0.1
        whiteMask.alpha = CGFloat(-4 + (current["score"] as! Int)) * 0.1
        scoreLabel.text = "\(current["score"]!)"
        categoryLabel.text = currentCategory()["name"] as? String
        timeLabel.text = formatter.string(from: Date().timeIntervalSince(current["started_at"] as! Date))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        updateLabels()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateLabels()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
