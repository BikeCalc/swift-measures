import Measures

@Converted(to: .megabytesPerSecond)
var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "12.5 MB/s"

downloadRate *= 2

print(downloadRate)
// Prints "25.0 MB/s"

downloadRate /= 2
