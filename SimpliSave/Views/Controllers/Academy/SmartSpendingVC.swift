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



class SmartSpendingVC: UIViewController,YTPlayerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        //playing the main video
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Smart Spending"
        videoCon.layer.cornerRadius = 15
        videoCon.layer.shadowOpacity=0.2
        videoCon.layer.shadowOffset.width=1
        videoCon.layer.shadowOffset.height=1.5
        
        needImage.layer.cornerRadius=15
        needImage.layer.shadowOpacity=0.2
        needImage.layer.shadowOffset.width=1
        needImage.layer.shadowOffset.height=1.5
        
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
        
       
      
        wantsImage.layer.cornerRadius=15
        wantsImage.layer.shadowOpacity=0.2
        wantsImage.layer.shadowOffset.width=1
        wantsImage.layer.shadowOffset.height=1.5
        
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
        
        
       
        spendImage.layer.cornerRadius=15
        spendImage.layer.shadowOpacity=0.2
        spendImage.layer.shadowOffset.width=1
        spendImage.layer.shadowOffset.height=1.5
        
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
        if let needImage = UserDefaults.standard.string(forKey: "needsImage") {
            if(needImage=="played"){
                img1.image = UIImage(systemName: "checkmark.circle.fill")
                img1.tintColor = UIColor(named: "green")
                
                
                let wantsImagePlayed=UserDefaults.standard.string(forKey: "wantsImagePlayed")
                let spending=UserDefaults.standard.string(forKey: "spendImagePlayed")
                
                if(wantsImagePlayed=="played" && spending=="played"){
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
    @IBOutlet weak var needImage: UIImageView!
    @IBOutlet weak var wantsImage: UIImageView!
    @IBOutlet weak var spendImage: UIImageView!
    
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
        playVideo(link: "https://youtu.be/B97W46GHOoQ")

    }
    
    var playerView: YTPlayerView!

    
    @IBAction func btnNeeds(_ sender: UIButton) {
        
        playVideo(link: "https://youtu.be/yL1t-PXQVls")
        btnMainVideo.isHidden=true
        
        
        // Save data
        UserDefaults.standard.set("played", forKey: "needsImage")

        

        
        img1.image = UIImage(systemName: "checkmark.circle.fill")
        img1.tintColor = UIColor(named: "green")
        //unlock video 2
        let wantsImagePlayed=UserDefaults.standard.string(forKey: "wantsImagePlayed")
        let spending=UserDefaults.standard.string(forKey: "spendImagePlayed")
        
        if(wantsImagePlayed=="played" && spending=="played"){
            img2.image = UIImage(systemName: "checkmark.circle.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else if(wantsImagePlayed=="played" && spending != "played"){
            img2.image = UIImage(systemName: "play.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else{
            //open the second video
            img2.image = UIImage(systemName: "lock.open")
        }
    }
    
    @IBAction func btnPlay2(_ sender: UIButton) {

        var needImage = UserDefaults.standard.string(forKey: "needsImage")
        if(needImage=="played"){
            //play video
            playVideo(link: "https://youtu.be/yL1t-PXQVls")
            UserDefaults.standard.set("played", forKey: "wantsImagePlayed")

            let wantsImagePlayed=UserDefaults.standard.string(forKey: "wantsImagePlayed")
            let spending=UserDefaults.standard.string(forKey: "spendImagePlayed")
            
            if(wantsImagePlayed=="played" && spending=="played"){
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
        var wantsImagePlayed = UserDefaults.standard.string(forKey: "wantsImagePlayed")
        if(wantsImagePlayed=="played"){
            playVideo(link: "https://www.youtube.com/watch?v=20IjthX-XcU")
            UserDefaults.standard.set("played", forKey: "spendImagePlayed")

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

    

