//
//  LookingMenuTests.swift
//  LookingMenuTests
//
//  Created by Huy Than Duc on 31/12/2020.
//

import XCTest
import Quick
import Nimble
@testable import LookingMenu

class LookingMenuTests: QuickSpec {
    let listKeyWordSearch = ["BURGER", "burger", "bur  ger", "bur@#ger!", "bur1ger2"]
    
    override func spec() {
        var searchView: SearchViewController!
        
        describe("Search View Controller") {
            beforeEach {
                searchView = StoryBoardReference.home.storyBoard.instantiateViewController(
                    withIdentifier: IdStoryBoardViews.searchVC) as? SearchViewController
                
                _ = searchView.view
                let mirror = SearchViewMirror(searchView: searchView)
                context("when search view is loaded") {
                    it("should have 10 recipe loaded") {
                        expect(mirror.resultSearchCollection?
                                .numberOfItems(inSection: 0)).to(equal(10))
                    }
                }
                
                context("totalResults label") {
                    it("content of label") {
                        expect(mirror.labelTotalResult?.text).to(equal("Found 146 results"))
                    }
                }

                context("check case key search") {
                    self.listKeyWordSearch.forEach {
                        APIRecipe.apiRecipe.searchRecipeByName(query: $0) { [unowned self] resultSearch in
                            let resultSearchToJson =  self.loadJson(fileName: "response")
                            expect(resultSearch).toNot(beNil())
                            expect(resultSearch).to(equal(resultSearchToJson))
                        }
                    }
                }
            }
        }
    }
    
    func loadJson(fileName: String) -> ResultSearch? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResultSearch.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
