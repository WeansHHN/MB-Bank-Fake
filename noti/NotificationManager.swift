import Foundation
import UserNotifications

class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification access granted.")
            } else if let error = error {
                print("Notification access denied: \(error.localizedDescription).")
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func scheduleNotification(account: String, amount: String, date: Date, time: Date, service: String, note: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let dateString = formatter.string(from: date)
        
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: time)
        
        let maskedAccount = maskAccountNumber(account)
        
        let content = UNMutableNotificationContent()
        content.title = "Thông báo biến động số dư"
        content.body = "TK \(maskedAccount)|GD: \(amount)VND \(dateString) \(timeString) |SD: \(service)VND|ND: \(note)"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
    // Handle notifications while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    private func maskAccountNumber(_ account: String) -> String {
        guard account.count >= 5 else { return account }
        let start = account.prefix(2)
        let end = account.suffix(3)
        return "\(start)xxx\(end)"
    }
}
