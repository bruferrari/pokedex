import Quick
import Nimble
@testable import GraphQlPlatform

class UseCaseProviderSpec: QuickSpec {
    override func spec() {
        let provider = UseCaseProvider()
        describe("UseCaseProvider") {
            it("correctly generate PokemonUseCase instance") {
                expect(provider.pokemonUseCase()).toNot(throwError())
            }
        }
    }
}
