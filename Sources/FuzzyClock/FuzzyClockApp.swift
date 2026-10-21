import SwiftUI

@main
struct FuzzyClockApp: App {
    @State private var clock = ClockModel()

    var body: some Scene {
        MenuBarExtra {
            Text(clock.exact)
            Divider()
            Button("Quit Fuzzy Clock") { NSApplication.shared.terminate(nil) }
                .keyboardShortcut("q")
        } label: {
            Text(clock.fuzzy)
        }
        .menuBarExtraStyle(.menu)
    }
}
