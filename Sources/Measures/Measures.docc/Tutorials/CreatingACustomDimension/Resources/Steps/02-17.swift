import Measures

@Converted(to: .megabytesPerSecond)
var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "12.5 MB/s"

downloadRate += .init(25, .megabitsPerSecond)

print(downloadRate)
// Prints "15.625 MB/s"

downloadRate += .init(8, .megabitsPerSecond)

print(downloadRate)
// Prints "16.625 MB/s"
