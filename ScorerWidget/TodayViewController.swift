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
    let categories = [
    Category.create(name: "睡眠", color: .cyan),
    Category.create(name: "勉強", color: .purple),
    Category.create(name: "仕事", color: .orange),
    ]
    var modified = false;
    var current = Spending.all().last ?? Spending.create(score: 4, category_id: 1, started_at: Date())
//    var currentCategory =
    let formatter = DateComponentsFormatter()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func switchCategory(_ sender: Any) {
        current = Spending.create(score: current.score, category_id: (current.category_id + 1) % 3, started_at: Date())
        print("\(current)")
        updateLabels()
    }
    
    @IBAction func plus(_ sender: Any) {
        current = Spending.create(score: ([current.score + 1, 5].min()!), category_id: current.category_id, started_at: Date())
        print("\(current)")
        updateLabels()
    }
    
    @IBAction func minus(_ sender: Any) {
        current = Spending.create(score: ([current.score - 1, 1].max()!), category_id: current.category_id, started_at: Date())
        print("\(current)")
        updateLabels()
    }
    
    func currentCategory() -> Category {
        return Category.find(id: current.category_id) ?? categories[current.category_id]
    }
    
    func updateLabels() {
        self.view.backgroundColor = currentCategory().color
        scoreLabel.text = "\(current.score)"
        categoryLabel.text = currentCategory().name
        timeLabel.text = formatter.string(from: Date().timeIntervalSince(current.started_at))
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
