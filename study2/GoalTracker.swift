import Foundation

class GoalTracker: ObservableObject {
    @Published var questionGoal: Int = 500
    @Published var ankiGoal: Int = 700

    func progress(for sessions: [Session], type: String) -> (done: Int, total: Int) {
        let startOfWeek = Calendar.current.startOfWeek(for: Date())
        let filtered = sessions.filter {
            $0.type == type && $0.startTime >= startOfWeek
        }
        let done = filtered.reduce(0) { $0 + ($1.actual ?? 0) }
        let total = type == "Questions" ? questionGoal : ankiGoal
        return (done, total)
    }
}

extension Calendar {
    func startOfWeek(for date: Date) -> Date {
        let comps = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: comps)!
    }
}
