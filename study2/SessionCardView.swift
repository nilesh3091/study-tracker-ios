import SwiftUI

struct SessionCardView: View {
    var session: Session

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(session.type) Session")
                .font(.headline)
            Text("🕓 \(session.startTime.formatted(.dateTime.hour().minute()))")
            Text("🎯 Goal: \(session.goal), ✅ Done: \(session.actual ?? 0)")
            Text("⏱️ Duration: \(Int(session.duration)) sec")
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
