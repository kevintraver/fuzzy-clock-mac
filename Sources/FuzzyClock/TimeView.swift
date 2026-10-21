import SwiftUI

struct TimeView: View {
    let clock: ClockModel
    let preferences: Preferences

    var body: some View {
        if preferences.showSeconds {
            // The clock model only ticks every 30 seconds, so drive the seconds from a timeline aligned to whole seconds
            TimelineView(.periodic(from: Calendar.current.startOfDay(for: .now), by: 1)) { context in
                content(context.date)
            }
        } else {
            content(clock.now)
        }
    }

    private func content(_ date: Date) -> some View {
        VStack(spacing: 4) {
            Text(date, format: preferences.showSeconds ? .dateTime.hour().minute().second() : .dateTime.hour().minute())
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .monospacedDigit()
            if preferences.showDate {
                Text(date, format: .dateTime.weekday(.wide).month(.wide).day())
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
        .padding(.vertical, 6)
    }
}
