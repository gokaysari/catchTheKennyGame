//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by Gökay Sarı on 15.08.2022.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView()]
    var hideTimer = Timer()
    var highScore = 0
    
    //views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var pic7: UIImageView!
    @IBOutlet weak var pic8: UIImageView!
    @IBOutlet weak var pic9: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        scoreLabel.text = "Score: \(score)"
        
        //highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        pic1.isUserInteractionEnabled = true
        pic2.isUserInteractionEnabled = true
        pic3.isUserInteractionEnabled = true
        pic4.isUserInteractionEnabled = true
        pic5.isUserInteractionEnabled = true
        pic6.isUserInteractionEnabled = true
        pic7.isUserInteractionEnabled = true
        pic8.isUserInteractionEnabled = true
        pic9.isUserInteractionEnabled = true

        
        let recog1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recog9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        
        pic1.addGestureRecognizer(recog1)
        pic2.addGestureRecognizer(recog2)
        pic3.addGestureRecognizer(recog3)
        pic4.addGestureRecognizer(recog4)
        pic5.addGestureRecognizer(recog5)
        pic6.addGestureRecognizer(recog6)
        pic7.addGestureRecognizer(recog7)
        pic8.addGestureRecognizer(recog8)
        pic9.addGestureRecognizer(recog9)

        kennyArray = [pic1,pic2,pic3,pic4,pic5,pic6,pic7,pic8,pic9]
        
        
        //timers
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    @objc func hideKenny()
    {
        for kenny in kennyArray
        {
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    
    @objc func increaseScore()
    {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }


    @objc func countDown()
    {
        counter -= 1
        timeLabel.text = String(counter)
        
        if(counter == 0){
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray
            {
                kenny.isHidden = true
            }
            
            //highscore
            
            if self.score > self.highScore
            {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //ALert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Play again!", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }

}

