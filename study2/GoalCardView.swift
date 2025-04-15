import SwiftUI

struct GoalCardView: View {
    var icon: String
    var title: String
    var progress: (done: Int, total: Int)
    var color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(icon)
                .font(.largeTitle)
            Text("\(progress.done)/\(progress.total)")
                .bold()
            Text("\(title)/week")
                .font(.caption)
                .foregroundColor(.gray)

            ProgressView(value: Double(progress.done), total: Double(progress.total))
                .tint(color)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .frame(width: 140)
    }
}
