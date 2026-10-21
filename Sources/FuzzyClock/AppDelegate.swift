import AppKit
import SwiftUI

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    private let clock = ClockModel()
    private let preferences = Preferences()
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private lazy var timeView = NSHostingView(rootView: TimeView(clock: clock, preferences: preferences))
    private var settingsWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let timeItem = NSMenuItem()
        // Stretch to the menu's width so the content centers
        timeView.autoresizingMask = .width
        timeItem.view = timeView

        let menu = NSMenu()
        menu.delegate = self
        menu.addItem(timeItem)
        menu.addItem(.separator())
        menu.addItem(withTitle: "Settings…", action: #selector(openSettings), keyEquivalent: ",").target = self
        menu.addItem(withTitle: "Quit Fuzzy Clock", action: #selector(NSApplication.terminate), keyEquivalent: "q")
        statusItem.menu = menu

        updateTitle()
    }

    // The date line can be toggled in settings, so resize the time view each time the menu opens
    func menuNeedsUpdate(_ menu: NSMenu) {
        timeView.frame.size = timeView.fittingSize
    }

    private func updateTitle() {
        withObservationTracking {
            statusItem.button?.title = preferences.lowercase ? clock.fuzzy.lowercased() : clock.fuzzy
        } onChange: {
            Task { @MainActor in self.updateTitle() }
        }
    }

    @objc private func openSettings() {
        if settingsWindow == nil {
            let window = NSWindow(contentViewController: NSHostingController(rootView: SettingsView(preferences: preferences)))
            window.title = "Fuzzy Clock Settings"
            window.styleMask = [.titled, .closable]
            window.isReleasedWhenClosed = false
            window.center()
            settingsWindow = window
        }
        NSApp.activate()
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
}
