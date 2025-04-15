import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var showingNewSession = false
    @Query(sort: \Session.startTime, order: .reverse) var sessions: [Session]

    var body: some View {
        NavigationView {
            ZStack {
                List(sessions) { session in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🕓 \(session.startTime.formatted(.dateTime.year().month().day().hour().minute()))")
                        Text("⏱️ \(Int(session.duration)) sec")
                        Text("🎯 Goal: \(session.goal), ✅ Done: \(session.actual ?? 0)")
                    }
                    .padding(6)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingNewSession = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Study Sessions")
            .sheet(isPresented: $showingNewSession) {
                NewSessionView()
            }
        }
    }
}
