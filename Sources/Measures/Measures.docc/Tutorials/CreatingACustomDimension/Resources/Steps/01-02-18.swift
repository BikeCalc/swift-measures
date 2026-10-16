import Measures

@Converted(to: .megabytesPerSecond)
var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "12.5 MB/s"
