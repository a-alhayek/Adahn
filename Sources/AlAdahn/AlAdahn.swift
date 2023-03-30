import Adhan
import Foundation

public protocol PrayerNameAndTime: Identifiable, Equatable {
    var name: String { get }
    var time: Date { get }
}

extension PrayerNameAndTime {
    var id: String { name }
}

public enum AlAdahnServiceError: LocalizedError {
    case failedToCalculatePrayerTime
}


public protocol PrayerTimeService {
    func getPrayerTime(for coordinates: Coordinates,
                       date: DateComponents,
                       calculationMethod: CalculationMethod) throws -> [any PrayerNameAndTime]
}

final class PrayerTimeServiceImpl: PrayerTimeService {
    
    func getPrayerTime(for coordinates: Coordinates, date: DateComponents, calculationMethod: CalculationMethod) throws -> [any PrayerNameAndTime] {
        let prayerTime = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: calculationMethod.params)
        if let prayerTime {
            let prayers: [PrayerNameAndDateImpl] = [
                .init(name: "Fajr", time: prayerTime.fajr),
                .init(name: "Sunrise", time: prayerTime.sunrise)                         ,
                .init(name: "Duhur", time: prayerTime.dhuhr),
                .init(name: "Asr", time:  prayerTime.asr),
                .init(name: "Maghrib", time: prayerTime.maghrib),
                .init(name: "isha", time: prayerTime.isha)]
            return prayers
        }
        throw  AlAdahnServiceError.failedToCalculatePrayerTime
    }
}
protocol PrayerDateFormatter {
    func timeIn12(from date: Date) -> String
    
    func timeIn24(from date: Date) -> String
}
public final class PrayerDateFormatterImpl: DateFormatter, PrayerDateFormatter {
    
    func timeIn12(from date: Date) -> String {
        dateFormat = "h:mm a"
        return string(from: date)
    }
    
    func timeIn24(from date: Date) -> String {
        dateFormat = "H:mm a"
        return string(from: date)
    }
}

struct PrayerNameAndDateImpl: PrayerNameAndTime {
    let name: String
    let time: Date
}
