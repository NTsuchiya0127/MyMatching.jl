function MyMatching(m_prefs, f_prefs)
    m = length(m_prefs)
    n = length(f_prefs)
    m_matched = Array{Float64}(m)
    for i in 1:m
        m_matched[i] = -1
    end
    f_matched = zeros(n)
    for j in 1:m
        k = 1
        while k <= length(m_prefs[j]) && m_matched[j] == -1
            if f_matched[m_prefs[j][k]] == 0
                if sum(f_prefs[m_prefs[j][k]] .== j) == 1
                    m_matched[j] = m_prefs[j][k]
                    f_matched[m_prefs[j][k]] = j
                else
                    f_matched[m_prefs[j][k]] = 0
                end
            else
                if searchsortedfirst(f_prefs[m_prefs[j][k]], j) < searchsortedfirst(f_prefs[m_prefs[j][k]], f_matched[m_prefs[j][k]])
                    m_matched[j] = m_prefs[j][k]
                    m_matched[f_matched[m_prefs[j][k]]] = -1
                    f_matched[[m_prefs[j][k]]] = j
                end
            end
            k += 1
        end
    end
    for l in 1:m
        if m_matched[l] == -1
            m_matched[l] = 0
        end
    end
    return m_matched, f_matched
end
