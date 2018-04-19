import Foundation
import Quick
import Nimble
import Fakery
import Domain
@testable import GraphQlPlatform

class AllPokemonQueryDataSpec: QuickSpec {
    override func spec() {
        describe("AllPokemonQuery data") {
            it("is correctly parsed to pokemon entity") {
                let graphPokemon = GraphQLFaker.makePokemon()
                expect(graphPokemon.pokemon()).toNot(beNil())
            }

            it("returns nil when try to parse an invalid data") {
                var graphPokemon1 = GraphQLFaker.makePokemon()
                var graphPokemon2 = GraphQLFaker.makePokemon()
                graphPokemon1.number = nil
                graphPokemon2.name = nil

                expect(graphPokemon1.pokemon()).to(beNil())
                expect(graphPokemon2.pokemon()).to(beNil())
            }
        }
    }
}
