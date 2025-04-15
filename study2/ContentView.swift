import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Session.startTime, order: .reverse) private var sessions: [Session]

    @State private var showingNewSession = false
    @State private var showingGoalEditor = false
    @StateObject private var goalTracker = GoalTracker()
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    // MARK: - Header
                    HStack {
                        Text("Home")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: {
                            isDarkMode.toggle()
                        }) {
                            Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .padding(.trailing, 8)
                        Button(action: {
                            showingGoalEditor = true
                        }) {
                            Text("Add a Goal")
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()

                    // MARK: - Goals Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 24) {
                            Button(action: { showingGoalEditor = true }) {
                                CompactGoalRingView(label: "Q", done: goalTracker.progress(for: sessions, type: "Questions").done, total: goalTracker.progress(for: sessions, type: "Questions").total)
                            }
                            Button(action: { showingGoalEditor = true }) {
                                CompactGoalRingView(label: "C", done: goalTracker.progress(for: sessions, type: "Anki").done, total: goalTracker.progress(for: sessions, type: "Anki").total)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                    }
                    .padding(.bottom)

                    // MARK: - Session Feed
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(sessions) { session in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "person.circle")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        VStack(alignment: .leading) {
                                            Text("Nilesh Kumar")
                                                .bold()
                                            Text("Today at \(session.startTime.formatted(date: .omitted, time: .shortened))")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }

                                    Text("\(session.type) Session")
                                        .font(.headline)

                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Done")
                                                .font(.caption)
                                            Text("\(session.actual ?? 0)")
                                                .bold()
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("Goal")
                                                .font(.caption)
                                            Text("\(session.goal)")
                                                .bold()
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("Time")
                                                .font(.caption)
                                            Text("\(Int(session.duration)) sec")
                                                .bold()
                                        }
                                    }
                                    .padding(.top, 4)

                                    Divider()

                                    HStack {
                                        Image(systemName: "hand.thumbsup")
                                        Spacer()
                                        Image(systemName: "message")
                                        Spacer()
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                    .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom)
                    }
                }

                // Floating Action Button
                Button(action: {
                    showingNewSession = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingNewSession) {
                NewSessionView()
            }
            .sheet(isPresented: $showingGoalEditor) {
                EditGoalsView(goalTracker: goalTracker)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct CompactGoalRingView: View {
    let label: String
    let done: Int
    let total: Int

    var progress: Double {
        guard total > 0 else { return 0 }
        return Double(done) / Double(total)
    }

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 6)
                    .frame(width: 70, height: 70)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.green, lineWidth: 6)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 70, height: 70)
                Text(label)
                    .font(.headline)
            }
            Text("\(done)")
                .bold()
                .font(.headline)
            Text("\(total)/week")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
