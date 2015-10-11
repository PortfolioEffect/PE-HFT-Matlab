function terms = util_strsplit(s, delimiter)

assert(ischar(s) && ndims(s) == 2 && size(s,1) <= 1, ...
    'strsplit:invalidarg', ...
    'The first input argument should be a char string.');

if nargin < 2
    by_space = true;
else
    d = delimiter;
    assert(ischar(d) && ndims(d) == 2 && size(d,1) == 1 && ~isempty(d), ...
        'strsplit:invalidarg', ...
        'The delimiter should be a non-empty char string.');
    
    d = strtrim(d);
    by_space = isempty(d);
end
s = strtrim(s);

if by_space
    w = isspace(s);            
    if any(w)
        dw = diff(w);
        sp = [1, find(dw == -1) + 1];    
        ep = [find(dw == 1), length(s)];    
        nt = numel(sp);
        terms = cell(1, nt);
        for i = 1 : nt
            terms{i} = s(sp(i):ep(i));
        end                
    else
        terms = {s};
    end
    
else    
    p = strfind(s, d);
    if ~isempty(p)           
        nt = numel(p) + 1;
        terms = cell(1, nt);
        sp = 1;
        dl = length(delimiter);
        for i = 1 : nt-1
            terms{i} = strtrim(s(sp:p(i)-1));
            sp = p(i) + dl;
        end         
        terms{nt} = strtrim(s(sp:end));
    else
        terms = {s};
    end        
end
