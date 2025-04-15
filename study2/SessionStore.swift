import Foundation

class SessionStore: ObservableObject {
    @Published var sessions: [Session] = []
}
