# Fish shell function for compiling and running C++ files which I use in programming contests.
# Does not recompile if the file hasn't changed. This is checked by keeping the file's hash.

function run
    set n (count $argv)
    if math "1!=$n" >/dev/null
        echo "Expected one argument: name of file to run"
        return 1
    end

    # removes trailing ".cpp" if necessary
    set name (string replace -r ".cpp\$" "" $argv[1])

    if not test -f "$name.cpp"
        echo "$name.cpp does not exist."
        return 1
    end
    set recompile 1
    set new_hash (md5 <$name.cpp)
    if test -f ".$name.md5"
        set old_hash (cat ".$name.md5")
        if [ $old_hash = $new_hash ]
            set recompile 0
        end
    end

    if [ $recompile = 1 ]
        time \
            g++ \
                -Wall -g -Wno-sign-compare -Wshadow -Wno-unused-result \
                -fsanitize=address -std=c++17 \
                -DLOCAL \
                -o $name $name.cpp
        # -fno-omit-frame-pointer
        if [ $status = 1 ]
            echo "(Non-zero exit status)"
            return 1
        end
        echo "$new_hash" >".$name.md5"
    end

    eval ./$name
end
