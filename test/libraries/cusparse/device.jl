using CUDA.CUSPARSE
using SparseArrays
using CUDA.CUSPARSE: CuSparseDeviceVector, CuSparseDeviceMatrixCSC, CuSparseDeviceMatrixCSR,
                     CuSparseDeviceMatrixBSR, CuSparseDeviceMatrixCOO

@testset "cudaconvert" begin
    @test isbitstype(CuSparseDeviceVector{Float32, Cint, AS.Global})
    @test isbitstype(CuSparseDeviceMatrixCSC{Float32, Cint, AS.Global})
    @test isbitstype(CuSparseDeviceMatrixCSR{Float32, Cint, AS.Global})
    @test isbitstype(CuSparseDeviceMatrixBSR{Float32, Cint, AS.Global})
    @test isbitstype(CuSparseDeviceMatrixCOO{Float32, Cint, AS.Global})

    V = sprand(10, 0.5)
    cuV = CuSparseVector(V)
    @test cudaconvert(cuV) isa CuSparseDeviceVector{Float64, Cint, AS.Global}

    A = sprand(10, 10, 0.5)
    cuA = CuSparseMatrixCSC(A)
    @test cudaconvert(cuA) isa CuSparseDeviceMatrixCSC{Float64, Cint, AS.Global}

    cuA = CuSparseMatrixCSR(A)
    @test cudaconvert(cuA) isa CuSparseDeviceMatrixCSR{Float64, Cint, AS.Global}

    cuA = CuSparseMatrixCOO(A)
    @test cudaconvert(cuA) isa CuSparseDeviceMatrixCOO{Float64, Cint, AS.Global}

    cuA = CuSparseMatrixBSR(A, 2)
    @test cudaconvert(cuA) isa CuSparseDeviceMatrixBSR{Float64, Cint, AS.Global}
end
