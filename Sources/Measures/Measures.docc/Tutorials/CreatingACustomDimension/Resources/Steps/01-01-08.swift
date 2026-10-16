import Measures

struct DataTransferRate: Unit {
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
    )

    static let base: Self = .init(
        coefficient: 1,
        symbol: "b/s"
    )

    let validRange: ClosedRange<Double> = .zero ... .infinity
}
