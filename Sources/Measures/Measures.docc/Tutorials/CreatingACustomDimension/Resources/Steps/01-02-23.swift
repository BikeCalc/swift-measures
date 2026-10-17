import Measures

@Converted(to: .megabytesPerSecond)
var downloadRate: Measure<DataTransferRate> = .init(100, .megabitsPerSecond)

print(downloadRate)
// Prints "12.5 MB/s"

downloadRate -= .init(2.5, .megabytesPerSecond)

print(downloadRate)
// Prints "10.0 MB/s"

downloadRate -= .init(15, .megabytesPerSecond)

print(downloadRate)
// Prints "-5.0 MB/s"

print(downloadRate.isValid)
// Prints "false"
