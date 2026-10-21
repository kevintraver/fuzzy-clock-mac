import AppKit
import Observation

@MainActor
@Observable
final class ClockModel {
    private(set) var now = Date()

    var fuzzy: String { FuzzyTime.phrase(for: now) }

    var exact: String {
        now.formatted(.dateTime.hour().minute()) + " · "
            + now.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day())
    }

    @ObservationIgnored private var ticker: Task<Void, Never>?
    @ObservationIgnored private var observers: [NSObjectProtocol] = []

    init() {
        startTicker()

        let workspace = NSWorkspace.shared.notificationCenter
        let center = NotificationCenter.default
        let sources: [(NotificationCenter, Notification.Name)] = [
            (workspace, NSWorkspace.didWakeNotification),
            (center, .NSSystemTimeZoneDidChange),
            (center, .NSSystemClockDidChange),
        ]
        observers = sources.map { center, name in
            center.addObserver(forName: name, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated { self?.startTicker() }
            }
        }
    }

    // Refresh now, then at every :00 and :30 second boundary
    private func startTicker() {
        ticker?.cancel()
        ticker = Task { [weak self] in
            while !Task.isCancelled {
                guard let self else { return }
                self.now = Date()
                let elapsed = self.now.timeIntervalSince1970.truncatingRemainder(dividingBy: 30)
                try? await Task.sleep(for: .seconds(30 - elapsed))
            }
        }
    }
}
