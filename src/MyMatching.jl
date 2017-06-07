module MyMatching
function MyMatching(m_prefs, f_prefs)
    m = length(m_prefs)
    n = length(f_prefs)
    m_matched = Array{Int64}(1, m)
    f_matched = Array{Int64}(1, n)
    m_matched[1:end] = 0
    f_matched[1:end] = 0
    h = 1
    while h <= n
        for j in 1:m
            k = 1
            while k <= length(m_prefs[j])
                if m_matched[j] == 0
                    if f_matched[m_prefs[j][k]] == 0
                        if sum(f_prefs[m_prefs[j][k]] .== j) == 1
                            m_matched[j] = m_prefs[j][k]
                            f_matched[m_prefs[j][k]] = j
                        end
                    else
                        p = f_matched[m_prefs[j][k]]
                        q = 1
                        r = 1
                        while !(f_prefs[m_prefs[j][k]][q] == j)
                            q += 1
                        end
                        while !(f_prefs[m_prefs[j][k]][r] == p)
                            r += 1
                        end
                        if q < r
                            m_matched[p] = 0
                            m_matched[j] = m_prefs[j][k]
                            f_matched[[m_prefs[j][k]]] = j
                        end
                    end
                end
                k += 1
            end
        end 
        h += 1
    end
    return m_matched, f_matched
end
export my_deferred_acceptance
end
