import SwiftUI

@main
struct FuzzyClockApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    // The status item and windows are managed by AppDelegate
    var body: some Scene {
        Settings { EmptyView() }
    }
}
