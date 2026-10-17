import Measures

struct DataTransferRate: Equatable, Unit {
    let coefficient: Double
    let constant: Double
    let symbol: String

    init(
        coefficient: Double,
        constant: Double = 0,
        symbol: String
    ) {
        self.coefficient = coefficient
        self.constant = constant
        self.symbol = symbol
    }

    init(
        memory: Memory,
        time: Time
    ) {
        let coefficient: Double = memory.coefficient * (1 / time.coefficient)
        let symbol: String = memory.symbol + "/" + time.symbol

        self.init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    static let base: Self = .bitsPerSecond

    let validRange: ClosedRange<Double> = .zero ... .infinity

    static let gigabitsPerSecond: Self = .init(
        memory: .gigabit,
        time: .second
    )
    static let megabytesPerSecond: Self = .init(
        memory: .megabyte,
        time: .second
    )
    static let megabitsPerSecond: Self = .init(
        memory: .megabit,
        time: .second
    )
    static let bitsPerSecond: Self = .init(
        memory: .bit,
        time: .second
    )
}
