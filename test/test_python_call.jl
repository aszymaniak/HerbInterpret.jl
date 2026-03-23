using HerbCore
using HerbGrammar
using HerbInterpret
using PythonCall
using RuntimeGeneratedFunctions
using Test
RuntimeGeneratedFunctions.init(@__MODULE__)

const np = pyimport("numpy")

@testset "PythonCall" begin
    g = @cfgrammar begin
        Number = x
        Number = np.sin(Number)
    end
    input = Dict{Symbol,Any}(:x => 2)

    interp = make_interpreter(g; input_symbols=[:x], target_module=@__MODULE__)
    out = interp(@rulenode(2{1}), input)

    @test pyconvert(Float64, out) ≈ sin(2)
end
