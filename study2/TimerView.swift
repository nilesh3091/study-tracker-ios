import SwiftUI

struct TimerView: View {
    @Binding var duration: TimeInterval
    @State private var startDate = Date()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(Int(duration)) sec elapsed")
            .font(.title2)
            .onReceive(timer) { _ in
                duration = Date().timeIntervalSince(startDate)
            }
    }
}
