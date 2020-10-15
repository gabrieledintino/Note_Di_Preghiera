//
//  Canta_e_CamminaTests.swift
//  Canta e CamminaTests
//
//  Created by Gabriele on 14/10/2020.
//

import XCTest

@testable import Canta_e_Cammina

class Canta_e_CamminaTests: XCTestCase {
    var sut: Playlists!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = Playlists()
        sut.createPlaylist(playlistName: "Prima", songs: [Song.allSongsOrdered[1], Song.allSongsOrdered[2]])
        sut.createPlaylist(playlistName: "Seconda", songs: [Song.allSongsOrdered[2], Song.allSongsOrdered[3]])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(sut.debugDescription)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
