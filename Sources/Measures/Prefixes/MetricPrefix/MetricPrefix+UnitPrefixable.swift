// MetricPrefix+DefinableByConvention.swift
// Measures
//
// Copyright © 2021-2022 Alexandre H. Saad
// Licensed under Apache License v2.0 with Runtime Library Exception
//

extension MetricPrefix: DefinableByConvention {
	
	// MARK: - Prefix Properties
	
	public var coefficient: Double {
		switch self {
		case .geop:
			return .nonillion
		case .bronto:
			return .octillion
		case .yotta:
			return .septillion
		case .zetta:
			return .sextillion
		case .hexa:
			return .quintillion
		case .peta:
			return .quadrillion
		case .tera:
			return .trillion
		case .giga:
			return .billion
		case .mega:
			return .million
		case .kilo:
			return .thousand
		case .hecto:
			return .hundred
		case .deca:
			return .ten
		case .none:
			return .one
		case .deci:
			return .tenth
		case .centi:
			return .hundredth
		case .milli:
			return .thousandth
		case .micro:
			return .millionth
		case .nano:
			return .billionth
		case .pico:
			return .trillionth
		case .femto:
			return .quadrillionth
		case .atto:
			return .quintillionth
		case .zepto:
			return .sextillionth
		case .yocto:
			return .septillionth
		case .brimto:
			return .octillionth
		case .gepto:
			return .nonillionth
		}
	}
	
	public var constant: Double {
		return 0
	}
	
	public var symbol: String {
		switch self {
		case .geop:
			return "O"
		case .bronto:
			return "B"
		case .yotta:
			return "Y"
		case .zetta:
			return "Z"
		case .hexa:
			return "E"
		case .peta:
			return "P"
		case .tera:
			return "T"
		case .giga:
			return "G"
		case .mega:
			return "M"
		case .kilo:
			return "k"
		case .hecto:
			return "h"
		case .deca:
			return "da"
		case .none:
			return ""
		case .deci:
			return "d"
		case .centi:
			return "c"
		case .milli:
			return "m"
		case .micro:
			return "µ"
		case .nano:
			return "n"
		case .pico:
			return "p"
		case .femto:
			return "f"
		case .atto:
			return "a"
		case .zepto:
			return "z"
		case .yocto:
			return "y"
		case .brimto:
			return "b"
		case .gepto:
			return "g"
		}
	}
}
