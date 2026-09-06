import Measures

struct DataTransferRate: Measurable {
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

    static let base: Self = .bitsPerSecond

    static let validRange: ClosedRange<Double> = .zero ... .infinity

    static let gigabitsPerSecond: Self = Memory.gigabit.dividing(by: .second)
    static let megabytesPerSecond: Self = Memory.megabyte.dividing(by: .second)
    static let megabitsPerSecond: Self = Memory.megabit.dividing(by: .second)
    static let bitsPerSecond: Self = Memory.bit.dividing(by: .second)
}

extension Memory {
    func dividing(by time: Time) -> DataTransferRate {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
        let symbol: String = self.symbol + "/" + time.symbol

        return .init(
            coefficient: coefficient,
            symbol: symbol
        )
    }
}
