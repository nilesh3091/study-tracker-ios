import SwiftUI
import SwiftData

struct NewSessionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var type = "Questions"
    @State private var goal = ""
    @State private var actual = ""
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerRunning = false
    @State private var showGoalEntry = true
    @State private var showActualEntry = false
    @State private var startTime = Date()

    let types = ["Questions", "Anki"]

    var body: some View {
        VStack(spacing: 20) {
            if showGoalEntry {
                VStack(spacing: 16) {
                    TextField("Activity Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    TextField("Enter target count", text: $goal)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    Button("Start Activity") {
                        guard Int(goal) != nil else { return }
                        startTime = Date()
                        timerRunning = true
                        showGoalEntry = false
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top)
                }
            } else {
                Spacer()
                CircularTimerView(elapsedTime: $elapsedTime)
                Spacer()

                Button("Finish") {
                    timerRunning = false
                    showActualEntry = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .sheet(isPresented: $showActualEntry) {
            ActualEntrySheet()
        }
        .padding()
        .onDisappear {
            timerRunning = false
        }
    }

    @ViewBuilder
    private func ActualEntrySheet() -> some View {
        VStack(spacing: 20) {
            Text("How many did you actually do?")
                .font(.headline)

            TextField("Actual count", text: $actual)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Save Session") {
                saveSession()
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }

    private func saveSession() {
        guard let g = Int(goal), let a = Int(actual) else { return }
        let session = Session(type: type, goal: g, duration: elapsedTime, startTime: startTime, title: title)
        session.actual = a
        session.endTime = Date()
        context.insert(session)
    }
}
