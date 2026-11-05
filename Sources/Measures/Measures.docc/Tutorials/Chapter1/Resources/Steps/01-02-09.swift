import Measures

var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "100.0 Mb/s"
