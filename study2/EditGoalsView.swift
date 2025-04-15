import SwiftUI

struct EditGoalsView: View {
    @ObservedObject var goalTracker: GoalTracker
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Weekly Goals")) {
                    Stepper("Questions: \(goalTracker.questionGoal)", value: $goalTracker.questionGoal, in: 0...1000)
                    Stepper("Anki Cards: \(goalTracker.ankiGoal)", value: $goalTracker.ankiGoal, in: 0...1000)
                }
            }
            .navigationTitle("Edit Goals")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
