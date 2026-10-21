import ServiceManagement
import SwiftUI

struct SettingsView: View {
    @Bindable var preferences: Preferences
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled

    var body: some View {
        Form {
            Toggle("Launch at login", isOn: Binding(get: { launchAtLogin }, set: setLaunchAtLogin))
            Toggle("Lowercase menu bar text", isOn: $preferences.lowercase)
            Toggle("Show date in menu", isOn: $preferences.showDate)
        }
        .formStyle(.grouped)
        .scrollDisabled(true)
        .frame(width: 360)
        .fixedSize(horizontal: false, vertical: true)
    }

    private func setLaunchAtLogin(_ enabled: Bool) {
        // If registration fails the toggle snaps back to the real state
        try? enabled ? SMAppService.mainApp.register() : SMAppService.mainApp.unregister()
        launchAtLogin = SMAppService.mainApp.status == .enabled
    }
}
