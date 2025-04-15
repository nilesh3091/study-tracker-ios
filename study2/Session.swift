import Foundation
import SwiftData

@Model
class Session {
    var id: UUID
    var type: String        // "Questions" or "Anki"
    var title: String?
    var goal: Int
    var actual: Int?
    var duration: TimeInterval
    var startTime: Date
    var endTime: Date?

    init(type: String, goal: Int, duration: TimeInterval, startTime: Date, title: String? = nil) {
        self.id = UUID()
        self.type = type
        self.title = title
        self.goal = goal
        self.duration = duration
        self.startTime = startTime
    }
}
