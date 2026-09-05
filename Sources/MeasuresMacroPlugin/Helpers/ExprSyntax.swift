// This source file is part of the Measures open source project
//
// Copyright (c) 2021-2026 A. H. de Quatre Ltd. and the Measures project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.md for license information
// See CONTRIBUTORS.txt for the list of Measures project authors

import SwiftSyntax

extension ExprSyntax {
    internal var stringLiteralValue: String? {
        guard let literal = self.as(StringLiteralExprSyntax.self),
              literal.segments.count == 1,
              case let .stringSegment(segment)? = literal.segments.first else {
            return nil
        }

        return segment.content.text
    }
}
