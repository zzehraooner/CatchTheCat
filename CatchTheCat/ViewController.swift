//
//  ViewController.swift
//  CatchTheCat
//
//  Created by Zehra Öner on 31.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var score=0
    var timer = Timer()
    var counter = 0
    var catArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var cat1: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    @IBOutlet weak var cat7: UIImageView!
    @IBOutlet weak var cat8: UIImageView!
    @IBOutlet weak var cat9: UIImageView!
    @IBOutlet weak var cat10: UIImageView!
    @IBOutlet weak var cat11: UIImageView!
    @IBOutlet weak var cat12: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text="Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil{
            highScore=0
            highScoreLabel.text="High Score: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore=newScore
            highScoreLabel.text="High Score: \(highScore)"

        }
        
        
        cat1.isUserInteractionEnabled=true
        cat2.isUserInteractionEnabled=true
        cat3.isUserInteractionEnabled=true
        cat4.isUserInteractionEnabled=true
        cat5.isUserInteractionEnabled=true
        cat6.isUserInteractionEnabled=true
        cat7.isUserInteractionEnabled=true
        cat8.isUserInteractionEnabled=true
        cat9.isUserInteractionEnabled=true
        cat10.isUserInteractionEnabled=true
        cat11.isUserInteractionEnabled=true
        cat12.isUserInteractionEnabled=true
        
        catArray = [cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9, cat10, cat11, cat12]
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        cat1.addGestureRecognizer(recognizer1)
        cat2.addGestureRecognizer(recognizer2)
        cat3.addGestureRecognizer(recognizer3)
        cat4.addGestureRecognizer(recognizer4)
        cat5.addGestureRecognizer(recognizer5)
        cat6.addGestureRecognizer(recognizer6)
        cat7.addGestureRecognizer(recognizer7)
        cat8.addGestureRecognizer(recognizer8)
        cat9.addGestureRecognizer(recognizer9)
        cat10.addGestureRecognizer(recognizer10)
        cat11.addGestureRecognizer(recognizer11)
        cat12.addGestureRecognizer(recognizer12)
        
        
        
        
        counter=30
        timeLabel.text=String(counter)
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(countDown), userInfo: nil, repeats: true)
        hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(hideCat), userInfo: nil, repeats: true)
        hideCat()
        
    }
    @objc func hideCat(){
        for cat in catArray{
            cat.isHidden=true
        }
        let random = Int(arc4random_uniform(UInt32(catArray.count - 1)))
        catArray[random].isHidden=false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text="Score: \(score)"
    }
    @objc func countDown(){
        counter-=1
        timeLabel.text=String(counter)
        if counter==0{
            timer.invalidate()
            hideTimer.invalidate()
            for cat in catArray{
                cat.isHidden=true
            }
            if self.score > self.highScore{
                self.highScore=self.score
                highScoreLabel.text="High Score: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highScore")
            }
            
            
            
            
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                
                self.score=0
                self.scoreLabel.text="Score: \(self.score)"
                self.counter=30
                self.timeLabel.text=String(self.counter)
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(self.hideCat), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert,animated: true, completion: nil)
        }
    }
}

