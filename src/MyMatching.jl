module MyMatching
# 多対一のケース
function my_deferred_acceptance(prop_prefs::Vector{Vector{Int}},
                    resp_prefs::Vector{Vector{Int}},
                    caps::Vector{Int})
    
    m = length(prop_prefs)
    L = sum(caps)
    n = length(caps)
    prop_matched = Vector{Int64}(m)
    resp_matched = Vector{Int64}(L)
    prop_matched[1:end] = 0
    resp_matched[1:end] = 0
    indptr = Array{Int}(n+1)
    indptr[1] = 1
    for g in 1:n
        indptr[g+1] = indptr[g] + caps[g]
    end

    h = 1
    while h <= n
        for j in 1:m
            k = 1
            while k <= length(prop_prefs[j])
                if prop_matched[j] == 0
                    if j in resp_prefs[prop_prefs[j][k]]
                        v = resp_matched[indptr[prop_prefs[j][k]]:indptr[prop_prefs[j][k]+1]-1]
                        if 0 in v
                            prop_matched[j] = prop_prefs[j][k]
                            t = 1
                            while !(v[t] == 0)
                                t += 1
                            end
                            resp_matched[indptr[prop_prefs[j][k]]+t-1] = j
                        else
                            s = 1
                            while findfirst(resp_prefs[prop_prefs[j][k]], v[s]) <= findfirst(resp_prefs[prop_prefs[j][k]], j)
                                if s <= length(v)
                                    s += 1
                                end
                                if s > length(v)
                                    break
                                end
                            end
                            if s <= length(v)
                                prop_matched[v[s]] = 0
                                prop_matched[j] = prop_prefs[j][k]
                                resp_matched[indptr[prop_prefs[j][k]]+s-1] = j
                            end
                        end
                    end
                end
                k += 1
            end
        end
        h += 1
    end   
    
    return prop_matched, resp_matched, indptr
end

# 一対一のケース
function my_deferred_acceptance(prop_prefs::Vector{Vector{Int}},
                    resp_prefs::Vector{Vector{Int}})
                    caps = ones(Int, length(resp_prefs))
    prop_matches, resp_matches, indptr = MyMatching(prop_prefs, resp_prefs, caps)
    return prop_matched, resp_matched
end
export my_deferred_acceptance
end
