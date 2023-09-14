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



class SavingsVC: UIViewController,YTPlayerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.title = "Savings"
        
        //playing the main video
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
        
       
      
        spendImage.layer.cornerRadius=15
        spendImage.layer.shadowOpacity=0.2
        spendImage.layer.shadowOffset.width=1
        spendImage.layer.shadowOffset.height=1.5
        
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
        
        
       
        wantsImage.layer.cornerRadius=15
        wantsImage.layer.shadowOpacity=0.2
        wantsImage.layer.shadowOffset.width=1
        wantsImage.layer.shadowOffset.height=1.5
        
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
        if let needImage = UserDefaults.standard.string(forKey: "whatSaving") {
            if(needImage=="played"){
                img1.image = UIImage(systemName: "checkmark.circle.fill")
                img1.tintColor = UIColor(named: "green")
                
                //let wantsImage=UserDefaults.standard.string(forKey: "whatSaving")
                let howTosave=UserDefaults.standard.string(forKey: "howTosave")
                let whenToSave=UserDefaults.standard.string(forKey: "whenToSave")
                
                if(howTosave=="played" && whenToSave=="played"){
                    img2.image = UIImage(systemName: "checkmark.circle.fill")
                    img2.tintColor = UIColor(named: "green")
                    
                    //last video
                    img3.image = UIImage(systemName: "play.fill")
                    img3.tintColor = UIColor(named: "blue")
                    
                }
                
                else{
                    //open the second video
                    img2.image = UIImage(systemName: "play.fill")
                    img2.tintColor = UIColor(named: "blue")
                }
                
                
               
            }
        }

        
    }
    
    @IBOutlet weak var videoCon: UIView!
    
    
    @IBOutlet weak var needImage: UIImageView!
    @IBOutlet weak var spendImage: UIImageView!
    @IBOutlet weak var wantsImage: UIImageView!
    
    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var btnMainVideo: UIButton!
    
    @IBAction func btnMainVideo(_ sender: UIButton) {
        playVideo(link: "https://youtu.be/pin9j6fjXmg")

    }
    
    var playerView: YTPlayerView!

    
    //calling the function playVideo() and passing the link for what is saving
    @IBAction func btnNeeds(_ sender: UIButton) {
        
        playVideo(link: "https://youtu.be/HNSe6F1KmZo")
        btnMainVideo.isHidden=true
        
        
        // Save data
        UserDefaults.standard.set("played", forKey: "whatSaving")

        

        
        img1.image = UIImage(systemName: "checkmark.circle.fill")
        img1.tintColor = UIColor(named: "green")
        //unlock video 2
        let howTosave=UserDefaults.standard.string(forKey: "howTosave")
        let spending=UserDefaults.standard.string(forKey: "whenToSave")
        
        if(howTosave=="played" && spending=="played"){
            img2.image = UIImage(systemName: "checkmark.circle.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else if(howTosave=="played" && spending != "played"){
            img2.image = UIImage(systemName: "play.fill")
            img2.tintColor = UIColor(named: "green")
        }
        else{
            //open the second video
            img2.image = UIImage(systemName: "lock.open")
        }
    }
    
    //How to save
    @IBAction func btnPlay2(_ sender: UIButton) {

        var needImage = UserDefaults.standard.string(forKey: "whatSaving")
        if(needImage=="played"){
            //play video
            playVideo(link: "https://youtu.be/ZfCUo1Hb8T4")
            UserDefaults.standard.set("played", forKey: "howTosave")

            let howTosave=UserDefaults.standard.string(forKey: "howTosave")
            let spending=UserDefaults.standard.string(forKey: "whenToSave")
            
            if(howTosave=="played" && spending=="played"){
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
    //When to save
     @IBAction func btnPlay3(_ sender: UIButton) {
        var howTosave = UserDefaults.standard.string(forKey: "howTosave")
        if(howTosave=="played"){
            playVideo(link: "https://youtu.be/RjBnTMToG34")
            UserDefaults.standard.set("played", forKey: "whenToSave")

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

    


