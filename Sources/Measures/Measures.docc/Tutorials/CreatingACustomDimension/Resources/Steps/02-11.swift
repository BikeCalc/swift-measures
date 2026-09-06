import Measures

var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "100.0 Mb/s"

downloadRate.convert(to: .megabytesPerSecond)

print(downloadRate)
// Prints "12.5 MB/s"
