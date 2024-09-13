//
//  Copyright © 2024 NewsReader. All rights reserved.
//

import XCTest

@testable import NewsReader

class NewsReaderTests: XCTestCase {
    var subject: ListSection!
    
    override func setUpWithError() throws {
        subject = ListSection(
            index: 0,
            items: []
        )
    }

    override func tearDownWithError() throws {}

    func testListSection() throws {
        XCTAssert(!subject.items.isEmpty)
    }

}
