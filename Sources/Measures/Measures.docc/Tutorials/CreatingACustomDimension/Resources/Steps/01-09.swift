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

    static let base: Self = .init(
        coefficient: 1,
        symbol: "b/s"
    )

    static let validRange: ClosedRange<Double> = .zero ... .infinity
}

extension Memory {
    func dividing(by time: Time) -> DataTransferRate {
        let coefficient: Double = self.coefficient * (1 / time.coefficient)
    }
}
