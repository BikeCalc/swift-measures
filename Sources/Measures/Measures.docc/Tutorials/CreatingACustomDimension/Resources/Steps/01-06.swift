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
}
