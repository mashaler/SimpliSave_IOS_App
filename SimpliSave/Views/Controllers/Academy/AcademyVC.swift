//
//  AcademyVC.swift
//  SimpliSave
//
//  Created by DA MAC  M1 154 on 2023/07/18.
//

import UIKit

class AcademyVC: UIViewController {
    
// MARK: - Outlets
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var progressbar: UIView!
    @IBOutlet weak var moneyBasics: UIStackView!
    @IBOutlet weak var budgeting: UIStackView!
    @IBOutlet weak var savings: UIStackView!
    @IBOutlet weak var smartSpending: UIStackView!
    @IBOutlet weak var mbImage: UIImageView!
    @IBOutlet weak var bImage: UIImageView!
    @IBOutlet weak var sImage: UIImageView!
    @IBOutlet weak var ssImage: UIImageView!
    @IBOutlet weak var grad: UIStackView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
// MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customise progress bar, images and UIViews
        progressbar.layer.cornerRadius = 15.0
        progressbar.clipsToBounds = false
        progressbar.layer.shadowColor = UIColor.black.cgColor
        progressbar.layer.shadowOffset = CGSize(width: 0, height: 2)
        progressbar.layer.shadowOpacity = 0.1
        progressbar.layer.shadowRadius = 4
        
        moneyBasics.layer.cornerRadius = 15.0
        moneyBasics.clipsToBounds = false
        moneyBasics.layer.shadowColor = UIColor.black.cgColor
        moneyBasics.layer.shadowOffset = CGSize(width: 0, height: 2)
        moneyBasics.layer.shadowOpacity = 0.1
        moneyBasics.layer.shadowRadius = 4
        
        budgeting.layer.cornerRadius = 15.0
        budgeting.clipsToBounds = false
        budgeting.layer.shadowColor = UIColor.black.cgColor
        budgeting.layer.shadowOffset = CGSize(width: 0, height: 2)
        budgeting.layer.shadowOpacity = 0.1
        budgeting.layer.shadowRadius = 4
        
        savings.layer.cornerRadius = 15.0
        savings.clipsToBounds = false
        savings.layer.shadowColor = UIColor.black.cgColor
        savings.layer.shadowOffset = CGSize(width: 0, height: 2)
        savings.layer.shadowOpacity = 0.1
        savings.layer.shadowRadius = 4
        
        smartSpending.layer.cornerRadius = 15.0
        smartSpending.clipsToBounds = false
        smartSpending.layer.shadowColor = UIColor.black.cgColor
        smartSpending.layer.shadowOffset = CGSize(width: 0, height: 2)
        smartSpending.layer.shadowOpacity = 0.1
        smartSpending.layer.shadowRadius = 4
        
        
        mbImage.layer.cornerRadius = 15.0
        bImage.layer.cornerRadius = 15.0
        sImage.layer.cornerRadius = 15.0
        ssImage.layer.cornerRadius = 15.0
        
        grad.layer.cornerRadius = 15.0
        grad.layer.masksToBounds = false
        grad.layer.shadowColor = UIColor.black.cgColor
        grad.layer.shadowOffset = CGSize(width: 0, height: 2)
        grad.layer.shadowOpacity = 0.1
        grad.layer.shadowRadius = 4
       
        // added tap gestures to make images clickable
        
        let mbTapGesture = UITapGestureRecognizer(target: self, action: #selector(moneyBasicsTapped))
        mbImage.isUserInteractionEnabled = true
        mbImage.addGestureRecognizer(mbTapGesture)

        let bTapGesture = UITapGestureRecognizer(target: self, action: #selector(budgetingTapped))
        bImage.isUserInteractionEnabled = true
        bImage.addGestureRecognizer(bTapGesture)

        let sTapGesture = UITapGestureRecognizer(target: self, action: #selector(savingsTapped))
        sImage.isUserInteractionEnabled = true
        sImage.addGestureRecognizer(sTapGesture)

        let ssTapGesture = UITapGestureRecognizer(target: self, action: #selector(smartSpendingTapped))
        ssImage.isUserInteractionEnabled = true
        ssImage.addGestureRecognizer(ssTapGesture)
        
        updateProgressLabel(completionPercentage: 0.0)
    }

    
// MARK: - Actions
    
    //when tapped, opens the partcular view attached to that controller
    @objc func moneyBasicsTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let moneyBasicsVC = storyboard.instantiateViewController(withIdentifier: " MoneyBasicsVC") as? MoneyBasicsVC {
            navigationController?.pushViewController(moneyBasicsVC, animated: true)
        }
        print("Money Basics view tapped!")
        
        VideoCompletionManager.shared.setVideoCompleted("needs")
        updateProgressViews()
        updateProgressLabels()
    }

    @objc func budgetingTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let budgetingVC = storyboard.instantiateViewController(withIdentifier: "budgetting") as? BudgetingVC {
            navigationController?.pushViewController(budgetingVC, animated: true)
        }
        print("Budgeting view tapped!")
        
        VideoCompletionManager.shared.setVideoCompleted("wants")
        updateProgressViews()
        updateProgressLabels()
    }

    @objc func savingsTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let savingsVC = storyboard.instantiateViewController(withIdentifier: "Savings") as? SavingsVC {
            navigationController?.pushViewController(savingsVC, animated: true)
        }
        print("Savings view tapped!")
        
        VideoCompletionManager.shared.setVideoCompleted("saving")
        updateProgressViews()
        updateProgressLabels()
    }

    @objc func smartSpendingTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let smartSpendingVC = storyboard.instantiateViewController(withIdentifier: "SmartSpending") as? SmartSpendingVC {
            navigationController?.pushViewController(smartSpendingVC, animated: true)
        }
        print("Smart Spending view tapped!")
        
        
        VideoCompletionManager.shared.setVideoCompleted("spending")
        updateProgressViews()
        updateProgressLabels()
    }
    
    private func updateProgressViews() {
          let completedVideoCount = VideoCompletionManager.shared.getCompletedVideoCount()
          let totalVideoCount = VideoCompletionManager.shared.videoCompletionStatus.count
          let completionPercentage = CGFloat(completedVideoCount) / CGFloat(totalVideoCount)

          // Update the progress bar value and label 
          progressBarView.progress = Float(completionPercentage)
          updateProgressLabel(completionPercentage: completionPercentage)
      }
    
    private func updateProgressLabels() {
           let completedVideoCount = VideoCompletionManager.shared.getCompletedVideoCount()
           let totalVideoCount = VideoCompletionManager.shared.getTotalVideoCount()
           let completionPercentage = CGFloat(completedVideoCount) / CGFloat(totalVideoCount)

           let progressLabelText = VideoCompletionManager.shared.getProgressLabel(for: completionPercentage)
           progressLabel.text = progressLabelText
       }


      private func updateProgressLabel(completionPercentage: CGFloat) {
          let progressLabel = VideoCompletionManager.shared.getProgressLabel(for: completionPercentage)
          self.progressLabel.text = progressLabel
      }
}
