#if canImport(Testing)
import Testing
import RmpSerde

@Suite("RmpSerde Swift Export Tests")
struct RmpSerdeExportTests {
    @Test("RmpSerde swift module imported cleanly")
    func testSwiftModuleLoads() throws {
        #expect(Bool(true), "RmpSerde swift module imported cleanly")
    }
}
#elseif canImport(XCTest)
import XCTest
import RmpSerde

final class RmpSerdeExportTests: XCTestCase {
    func testSwiftModuleLoads() throws {
        XCTAssertTrue(true, "RmpSerde swift module imported cleanly")
    }
}
#endif
