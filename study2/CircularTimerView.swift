import SwiftUI

struct CircularTimerView: View {
    @Binding var elapsedTime: TimeInterval
    @State private var isRunning = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 12)
                    .foregroundColor(.gray.opacity(0.2))

                Circle()
                    .trim(from: 0, to: CGFloat(min(elapsedTime / 1500, 1)))
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                Text(formattedTime)
                    .font(.largeTitle.monospacedDigit())
                    .foregroundColor(.primary)
            }
            .frame(width: 150, height: 150)

            Button(action: {
                isRunning.toggle()
            }) {
                Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                elapsedTime += 1
            }
        }
    }
}
