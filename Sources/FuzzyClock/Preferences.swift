import Foundation
import Observation

@MainActor
@Observable
final class Preferences {
    var lowercase = UserDefaults.standard.bool(forKey: "lowercase") {
        didSet { UserDefaults.standard.set(lowercase, forKey: "lowercase") }
    }

    var showDate = UserDefaults.standard.object(forKey: "showDate") as? Bool ?? true {
        didSet { UserDefaults.standard.set(showDate, forKey: "showDate") }
    }

    var showSeconds = UserDefaults.standard.bool(forKey: "showSeconds") {
        didSet { UserDefaults.standard.set(showSeconds, forKey: "showSeconds") }
    }
}
