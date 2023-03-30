import XCTest
@testable import AlAdahn

final class AlAdahnTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    //    XCTAssertEqual(AlAdahn().text, "Hello, World!")
    }
}

final class PrayerDateFormmaterTest: XCTestCase {
    private var prayerDateFormatter: PrayerDateFormatter!
    
    override func setUpWithError() throws {
        prayerDateFormatter = PrayerDateFormatterImpl()
    }
    
    override func tearDownWithError() throws {
        prayerDateFormatter = nil
    }
    
    func testTimeWhenTheItsAmTime() throws {
        let date = Date(timeIntervalSince1970: 1680096613)
        let time12 = prayerDateFormatter.timeIn12(from: date)
        XCTAssertEqual(time12, "9:30 AM")
        
        let time24 = prayerDateFormatter.timeIn24(from: date)
        XCTAssertEqual(time24, "9:30 AM")
    }
    
    func testTimeWhenTheItsPmTime() throws {
        let date = Date(timeIntervalSince1970: 1680125413)
        let time12 = prayerDateFormatter.timeIn12(from: date)
        XCTAssertEqual(time12, "5:30 PM")
        
        let time24 = prayerDateFormatter.timeIn24(from: date)
        XCTAssertEqual(time24, "17:30 PM")
    }
}
