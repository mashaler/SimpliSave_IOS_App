//
//  VideoCompletionManager.swift
//  SimpliSave
//
//  Created by Masana on 2023/08/17.
//

import Foundation
import UIKit

// A singleton class for managing video completion statuses and progress labels

class VideoCompletionManager {
    // Shared instance accessible throughout the app
    static let shared = VideoCompletionManager()
    
    // Dictionary to store video completion statuses
    var videoCompletionStatus: [String: Bool] =
    [
        "needs": false,
        "wants": false,
        "saving": false,
        "spending": false
    ]
    
    // Labels to show progress as videos are watched
    private let progressLabels: [String] = [
        "Start watching videos",
        "Keep Going!",
        "Keep It Up!",
        "Almost There!",
        "Well Done!"
    ]
    
    // Marks a video as completed
    func setVideoCompleted(_ videoKey: String) {
        videoCompletionStatus[videoKey] = true
    }
    
    // Checks if a video is completed
    func isVideoCompleted(_ videoKey: String) -> Bool {
        return videoCompletionStatus[videoKey] ?? false
    }
    
    // Gets the count of completed videos
    func getCompletedVideoCount() -> Int {
        return videoCompletionStatus.values.filter { $0 }.count
    }
    
    // Gets the total count of videos
    func getTotalVideoCount() -> Int {
        return videoCompletionStatus.count
    }
    
    // Retrieves a progress label based on completion percentage
    func getProgressLabel(for completionPercentage: CGFloat) -> String {
        let labelIndex = min(Int(completionPercentage * CGFloat(progressLabels.count - 1)), progressLabels.count - 1)
        return progressLabels[labelIndex]
    }
}
