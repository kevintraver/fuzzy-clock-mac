import SwiftUI

struct TimeView: View {
    let clock: ClockModel
    let preferences: Preferences

    var body: some View {
        VStack(spacing: 4) {
            Text(clock.now, format: .dateTime.hour().minute())
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .monospacedDigit()
            if preferences.showDate {
                Text(clock.now, format: .dateTime.weekday(.wide).month(.wide).day())
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
    }
}
