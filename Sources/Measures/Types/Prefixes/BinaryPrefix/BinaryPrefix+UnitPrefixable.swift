// BinaryPrefix+DefinableByConvention.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension BinaryPrefix: DefinableByConvention {
	
	// MARK: - Prefix Properties
	
	public var coefficient: Double {
		switch self {
		case .yobi:
			return 1024.raising(to: 8)
		case .zebi:
			return 1024.raising(to: 7)
		case .exbi:
			return 1024.raising(to: 6)
		case .pebi:
			return 1024.raising(to: 5)
		case .tebi:
			return 1024.raising(to: 4)
		case .gibi:
			return 1024.raising(to: 3)
		case .mebi:
			return 1024.raising(to: 2)
		case .kibi:
			return 1024
		case .none:
			return 1
		}
	}
	
	public var constant: Double {
		return 0
	}
	
	public var symbol: String {
		switch self {
		case .yobi:
			return "Yi"
		case .zebi:
			return "Zi"
		case .exbi:
			return "Ei"
		case .pebi:
			return "Pi"
		case .tebi:
			return "Ti"
		case .gibi:
			return "Gi"
		case .mebi:
			return "Mi"
		case .kibi:
			return "Ki"
		case .none:
			return ""
		}
	}
}
