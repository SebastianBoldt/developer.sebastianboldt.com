import Foundation
import Vapor

public final class AllCapsLogger: LogProtocol {
    public var enabled: [LogLevel] = []
    let exclamationCount: Int
    public func log(_ level: LogLevel, message: String, file: String, function: String, line: Int) {
        print("Custom Logger \(message.uppercased())", String(repeating:"!", count: self.exclamationCount))
    }
    
    init(exclamationCount: Int) {
        self.exclamationCount = exclamationCount
    }
}

extension AllCapsLogger: ConfigInitializable {
    convenience public init(config: Config) {
        let count = config["allCaps","exclamationCount"]?.int ?? 3
        self.init(exclamationCount: count)
    }
}
