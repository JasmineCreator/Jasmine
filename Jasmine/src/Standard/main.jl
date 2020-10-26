abstract type AbstractStandard end

mutable struct Standard1{T} <: AbstractStandard
    M::Matrix{T}
    Base::Vector{Int64}
    
    function Standard1(A::Matrix{T}, c::Vector{T}, b::Vector{T}; verbose::Bool = false)  where  T
        if  verbose
            println("A = $A")
            println("b = $b")
            println("c = $c")
        end
        M = [A b; c' zero(T)]
        n = new{T}()
        n.M = M
        return n
    end
end
function find_exit(st::Standard1,enter::Int)
    Ak = st.M[1:end-1, enter]
    b = st.M[1:end-1, end]
    tmp = b ./ Ak
    val = Inf
    index = -1
    for i in 1:length(tmp)
        if (Ak[i] != 0)  && (tmp[i] < val)
            val = tmp[i]
            index = i
        end
    end
    if index == -1
        println("impossible de  trouver  une  varibale sortante")
    end
    return index
end

function find_enter(st::Standard1)
    c = st.M[end,1:end-1]
    arg = argmin(c)
    if c[arg] >= 0
        println("aucune variable ne peut entrer")
    else
        return arg
    end
end
function pivot!(st::Standard1, exit::Int, enter::Int)
    
end

function Optimize!(st::Standard1; nmax = 100)
    findfirstBase!(st)
    for k in 1:nmax
        if optimal(st)
            return sol(st)
        end
        enter = find_enter(st)
        exit = find_exit(st, enter)
        
        pivot!(st, exit, enter)
    end
    println("iteration max reached"
end

function findfirstBase!(st::Standard1)
    A = M[1:end-1,  1:end-1]
    b = M[1:end, 1:end -1]
    c = M[end,1:end-1]
    artif = [1:size(A,1);]
    Base = -ones(Int, size(A, 1))
    for k in 1:size(A, 2)
        Ak = A[:, k]
        nNotzero = count(!iszero, Ak)
        if nNotzeo == 1
            index = findfirst(!iszero, Ak)
            if index in artif
                artif = setdiff(index, artif)
                Base[index] = k
            end
        end
    end
    nartificial = count(x -> x == -1, Base)
    if nartificial == 0
        st.Base = Base
        return 
    else
        println("TODO")
        return 
    end
end