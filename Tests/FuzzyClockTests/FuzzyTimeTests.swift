import Testing
@testable import Fuzzy_Clock

struct FuzzyTimeTests {
    @Test(arguments: [
        (3, 0, 0, "Three o’clock"),
        (3, 0, 59, "Three o’clock"),
        (3, 1, 0, "Shortly after three"),
        (3, 2, 59, "Shortly after three"),
        (3, 3, 0, "Five past three"),
        (3, 8, 0, "Ten past three"),
        (3, 15, 0, "Quarter past three"),
        (3, 30, 0, "Half past three"),
        (3, 35, 0, "Twenty-five to four"),
        (3, 57, 59, "Five to four"),
        (3, 58, 0, "Nearly four"),
        (23, 58, 0, "Nearly midnight"),
        (0, 0, 0, "Midnight"),
        (0, 15, 0, "Quarter past midnight"),
        (11, 40, 0, "Twenty to noon"),
        (12, 0, 0, "Noon"),
        (13, 0, 0, "One o’clock"),
    ])
    func phrase(hour: Int, minute: Int, second: Int, expected: String) {
        #expect(FuzzyTime.phrase(hour: hour, minute: minute, second: second) == expected)
    }
}
