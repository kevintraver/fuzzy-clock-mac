import Foundation

enum FuzzyTime {
    private static let formats = [
        "{} o’clock",
        "shortly after {}",
        "five past {}",
        "ten past {}",
        "quarter past {}",
        "twenty past {}",
        "twenty-five past {}",
        "half past {}",
        "twenty-five to {}",
        "twenty to {}",
        "quarter to {}",
        "ten to {}",
        "five to {}",
        "nearly {}",
    ]

    private static let hourNames = [
        "twelve", "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine", "ten", "eleven",
    ]

    static func phrase(for date: Date, calendar: Calendar = .current) -> String {
        let parts = calendar.dateComponents([.hour, .minute, .second], from: date)
        return phrase(hour: parts.hour!, minute: parts.minute!, second: parts.second!)
    }

    static func phrase(hour: Int, minute: Int, second: Int) -> String {
        let state = state(minute: minute, second: second)

        // From "twenty-five to" onwards the phrase refers to the following hour
        let h = (hour + (state >= 8 ? 1 : 0)) % 24
        let hourName = switch h {
        case 0: "midnight"
        case 12: "noon"
        default: hourNames[h % 12]
        }

        let text = state == 0 && (h == 0 || h == 12)
            ? hourName
            : formats[state].replacingOccurrences(of: "{}", with: hourName)
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    private static func state(minute: Int, second: Int) -> Int {
        // Current 30 second step of the hour
        let step = minute * 2 + second / 30

        switch step {
        case ..<2: return 0                     // first minute sticks at the full hour
        case 2...5: return 1                    // shortly after
        case ..<116: return 1 + (step + 4) / 10 // round to 5 minute steps
        default: return 13                      // nearly the next hour
        }
    }
}
