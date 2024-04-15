import Foundation

public extension Date {
  static func - (lhs: Date, rhs: TimeInterval) -> Date {
    return Date(timeInterval: -rhs, since: lhs)
  }
  
  func dateRangeString(minusSeconds: TimeInterval) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    let startDate = self - minusSeconds
    let endDate = self
    
    let calendar = Calendar.current
    let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
    let endComponents = calendar.dateComponents([.year, .month, .day], from: endDate)
    
    let startTimeString: String
    if startComponents.day != endComponents.day {
      startTimeString = dateFormatter.string(from: startDate)
    } else {
      dateFormatter.dateFormat = "HH:mm"
      startTimeString = dateFormatter.string(from: startDate)
    }
    
    dateFormatter.dateFormat = "HH:mm"
    let endTimeString = dateFormatter.string(from: endDate)
    
    return "\(startTimeString) - \(endTimeString)"
  }
}
