//
//  SmartSpendingVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit
import WebKit
import AVKit
import youtube_ios_player_helper



class MoneyBasicsVC: UIViewController,YTPlayerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        //playing the main video
        
        
        //controlling how the frames should look like
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Money Basics"
        videoCon!.layer.cornerRadius = 15
        videoCon.layer.shadowOpacity=0.2
        videoCon.layer.shadowOffset.width=1
        videoCon.layer.shadowOffset.height=1.5
        
        part1.layer.cornerRadius=15
        part1.layer.shadowOpacity=0.2
        part1.layer.shadowOffset.width=1
        part1.layer.shadowOffset.height=1.5
        
        frame1.layer.cornerRadius=15
        frame1.layer.shadowOpacity=0.2
        frame1.layer.borderWidth=1
        frame1.layer.borderColor=UIColor(named: "absa")?.cgColor
        frame1.layer.shadowOffset.width=1
        frame1.layer.shadowOffset.height=1.5
        
       
        container1.layer.cornerRadius = 15
        container1.layer.shadowOpacity=0.2
        container1.layer.shadowOffset.width=1
        container1.layer.shadowOffset.height=1.5
        
       
      
        part2.layer.cornerRadius=15
        part2.layer.shadowOpacity=0.2
        part2.layer.shadowOffset.width=1
        part2.layer.shadowOffset.height=1.5
        
        frame2.layer.cornerRadius=15
        frame2.layer.shadowOpacity=0.2
        frame2.layer.borderWidth=1
        frame2.layer.borderColor=UIColor(named: "absa")?.cgColor
        frame2.layer.shadowOffset.width=1
        frame2.layer.shadowOffset.height=1.5
        
       
        container2.layer.cornerRadius = 15
        container2.layer.shadowOpacity=0.2
        container2.layer.shadowOffset.width=1
        container2.layer.shadowOffset.height=1.5
        
        
       
        part3.layer.cornerRadius=15
        part3.layer.shadowOpacity=0.2
        part3.layer.shadowOffset.width=1
        part3.layer.shadowOffset.height=1.5
        
        frame3.layer.cornerRadius=15
        frame3.layer.shadowOpacity=0.2
        frame3.layer.borderWidth=1
        frame3.layer.borderColor=UIColor(named: "absa")?.cgColor
        frame3.layer.shadowOffset.width=1
        frame3.layer.shadowOffset.height=1.5
        
       
        container3.layer.cornerRadius = 15
        container3.layer.shadowOpacity=0.2
        container3.layer.shadowOffset.width=1
        container3.layer.shadowOffset.height=1.5
        
        

        // Retrieve data
        if let needImage = UserDefaults.standard.string(forKey: "moneyB1") {
            if(needImage=="played"){
                img1.image = UIImage(systemName: "checkmark.circle.fill")
                img1.tintColor = UIColor(named: "green")
                
                
                let moneyB3=UserDefaults.standard.string(forKey: "moneyB3")
                let spending=UserDefaults.standard.string(forKey: "moneyB2")
                
                if(moneyB3=="played" && spending=="played"){
                    img2.image = UIImage(systemName: "checkmark.circle.fill")
                    img2.tintColor = UIColor(named: "green")
                    
                    //last video
                    img3.image = UIImage(systemName: "play.fill")
                    img3.tintColor = UIColor(named: "blue")
                    
                }
                
                else{
                    //open the second video
                    //img2.image = UIImage(systemName: "lock.open")
                    img2.image = UIImage(systemName: "play.fill")
                    img2.tintColor = UIColor(named: "blue")
                }
                
                
               
            }
        }

        
    }
    @IBOutlet weak var part1: UIImageView!
    @IBOutlet weak var part2: UIImageView!
    @IBOutlet weak var part3: UIImageView!
    
    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    
    @IBOutlet weak var videoCon: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var btnMainVideo: UIButton!
    
    @IBAction func btnMainVideo(_ sender: UIButton) {
        playVideo(link: "https://www.youtube.com/watch?v=GwAIu-RA_WA")


    }
    
    var playerView: YTPlayerView!

    
    @IBAction func btnPlay1(_ sender: UIButton) {
        playVideo(link: "https://www.youtube.com/watch?v=zNTNWQmf1DE")

        btnMainVideo.isHidden=true
        
        
        // Save data
        UserDefaults.standard.set("played", forKey: "moneyB1")

        

        
        img1.image = UIImage(systemName: "checkmark.circle.fill")
        img1.tintColor = UIColor(named: "green")
        //unlock video 2
        let moneyB3=UserDefaults.standard.string(forKey: "moneyB3")
        let spending=UserDefaults.standard.string(forKey: "moneyB2")
        
        if(moneyB3=="played" && spending=="played"){
            img2.image = UIImage(systemName: "checkmark.circle.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else if(moneyB3=="played" && spending != "played"){
            img2.image = UIImage(systemName: "play.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else{
            //open the second video
            img2.image = UIImage(systemName: "lock.open")
        }
    }
    
    @IBAction func btnPlay2(_ sender: UIButton) {

        var needImage = UserDefaults.standard.string(forKey: "moneyB1")
        if(needImage=="played"){
            //play video
            playVideo(link: "https://www.youtube.com/watch?v=sgCc1DhdsUc")
            UserDefaults.standard.set("played", forKey: "moneyB3")

            let moneyB3=UserDefaults.standard.string(forKey: "moneyB3")
            let spending=UserDefaults.standard.string(forKey: "moneyB2")
            
            if(moneyB3=="played" && spending=="played"){
                img2.image = UIImage(systemName: "checkmark.circle.fill")
                img2.tintColor = UIColor(named: "green")
            }
            
            else{
                //open the second video
                img2.image = UIImage(systemName: "play.fill")
                img2.tintColor = UIColor(named: "blue")
                //open the second video
                img3.image = UIImage(systemName: "lock.open")

            }
        }
        
        
        
    }
    @IBAction func btnPlay3(_ sender: UIButton) {
        var moneyB3 = UserDefaults.standard.string(forKey: "moneyB3")
        if(moneyB3=="played"){
            playVideo(link: "https://www.youtube.com/watch?v=e-P8HzVCgbQ")
            UserDefaults.standard.set("played", forKey: "moneyB2")

            img3.image = UIImage(systemName: "play.fill")
            img3.tintColor = UIColor(named: "blue")
            
            img2.image = UIImage(systemName: "checkmark.circle.fill")
            img2.tintColor = UIColor(named: "green")
            
        }
    }
    
    private func playVideo(link: String) {
        playerView = YTPlayerView(frame: videoCon.bounds)
        playerView.delegate = self
        videoCon.addSubview(playerView)

        // Extract the video ID from the YouTube URL
        if let videoID = extractVideoID(from: link) {
            // Load and play the YouTube video automatically
            playerView.load(withVideoId: videoID, playerVars: ["autoplay": 1])
        }
    }

    private func extractVideoID(from url: String) -> String? {
        // Regular expression pattern to match YouTube video IDs
        let pattern = #"(?<=youtu\.be\/|watch\?v=|\/videos\/|embed\/)[^#\&\?]*"# // This regex should handle most YouTube URLs

        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }

        let range = NSRange(url.startIndex..<url.endIndex, in: url)
        if let match = regex.firstMatch(in: url, options: [], range: range) {
            return String(url[Range(match.range, in: url)!])
        }

        return nil
    }

    }

    



