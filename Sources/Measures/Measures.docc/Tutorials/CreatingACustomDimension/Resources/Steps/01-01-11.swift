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
    ) {
        let coefficient: Double = memory.coefficient * (1 / time.coefficient)
        let symbol: String = memory.symbol + "/" + time.symbol
        self.init(
            coefficient: coefficient,
            symbol: symbol
        )
    }

    static let base: Self = .init(
        coefficient: 1,
        symbol: "b/s"
    )

    let validRange: ClosedRange<Double> = .zero ... .infinity
}
