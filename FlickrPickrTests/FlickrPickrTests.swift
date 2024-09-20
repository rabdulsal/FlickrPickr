//
//  FlickrPickrTests.swift
//  FlickrPickrTests
//
//  Created by Rashad Abdul-Salam on 9/19/24.
//

import Testing
import Foundation
import XCTest

@testable import FlickrPickr

struct FlickrPickrTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func testDateFormatterShouldProperlyFormatDates() {
        let utcDate = "2024-09-18T23:41:16Z"
        let challengeDate = "Sep 18, 2024"
        
        let formattedDate = DateFormatter.formattedPublishDate(utcDate)
        
        #expect(formattedDate == challengeDate, "FormattedDate and ChallengeDate should match.")
    }
}
