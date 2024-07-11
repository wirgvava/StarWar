//
//  CommonMethods.swift
//  StarWar
//
//  Created by Konstantine Tsirgvava on 04.07.24.
//

import UIKit
import UserNotifications

func vibration() {
    let generator = UIImpactFeedbackGenerator(style: .soft)
    generator.impactOccurred()
}

// Request notification permission
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
            print("Error requesting notification permission: \(error)")
        } else if granted {
            print("Notification permission granted")
        } else {
            print("Notification permission denied")
        }
    }
}

// Send notification
func sendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Pew Pew"
    content.body = "🚀 Time to shoot 👾"
    content.sound = UNNotificationSound.default
    
    // Extract date components from AppStorageManager.date
    let targetDate = AppStorageManager.date
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .day, .hour, .minute, .second], from: targetDate)
    
    // Create a calendar notification trigger
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request = UNNotificationRequest(identifier: "HealthRestored", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        } else {
            print("Notification scheduled for \(targetDate)")
        }
    }
}