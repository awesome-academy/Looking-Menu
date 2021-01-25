import XCTest
import Quick
import Nimble
@testable import LookingMenu

class LookingMenuTests: QuickSpec {
    let listKeyWordSearch = ["BURGER", "burger", "bur  ger", "bur@#ger!", "bur1ger2"]
    override func spec() {
        describe("Search View Controller") {
            var searchView: SearchViewController!
            var mirror: SearchViewMirror!
            var mirrorCell: ResultSearchViewMirror!
            
            beforeEach {
                searchView = StoryBoardReference.home.storyBoard.instantiateViewController(
                    withIdentifier: IdStoryBoardViews.searchVC) as? SearchViewController
                searchView.keyWord = "Burger"
                searchView.typeSearch = .searchName
                searchView.loadViewIfNeeded()
                mirror = SearchViewMirror(searchView: searchView)
                
                if let recipeCell = mirror.resultSearchCollection?
                    .cellForItem(at: IndexPath(row: 0, section: 0)) as? ResultSearchCell {
                    print(recipeCell)
                    mirrorCell = ResultSearchViewMirror(searchView: recipeCell)
                }
            }
            
            context("when search view is loaded") {
                it("should have 10 recipe loaded") {
                    expect(mirror.resultSearchCollection?.isHidden).toEventually(equal(false))
                    expect(mirror.resultSearchCollection?
                            .numberOfItems(inSection: 0)).toEventually(equal(10))
                }
            }
            
            context("totalResults label") {
                it("content of label") {
                    expect(mirror.labelTotalResult?.text).toEventually(equal("Found 147 results"))
                }
            }
            
            context("view not found") {
                it("hidden view") {
                    expect(mirror.viewRecipeNotFound?.isHidden).toEventually(equal(false))
                }
            }
            
            context("check case key search") {
                it("data api") {
                    self.listKeyWordSearch.forEach {
                        APIRecipe.apiRecipe.searchRecipeByName(query: $0) { [unowned self] resultSearch in
                            let resultSearchToJson = self.loadJson(fileName: "response")
                            expect(resultSearch).toNot(beNil())
                            expect(resultSearch).to(equal(resultSearchToJson))
                        }
                    }
                }
            }
            
            context("check label key word") {
                it("value label") {
                    expect(mirror.labelKeyWordSearch?.text).toEventually(equal("Burger"))
                }
            }
            
            context("content cell recipe") {
                it("recipe random cell") {
                    if let mirrorCell = mirrorCell {
                        expect(mirrorCell.titleRecipeLabel?.text).toEventually(equal("Falafel Burgers with Feta Cucumber Sauce"))
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
