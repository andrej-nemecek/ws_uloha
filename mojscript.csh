# !bin/csh
#
#Meno: Andrej Nemecek
#Datum: 17.03.2018
#Zadanie: Vypisat databazy so zadanou obsadenostou v percentach

@ obsadenost = 75
while($#argv > 0)
    switch("$argv[1]")
        case -h:
            echo "$0:t (c) Andrej Nemecek"
            echo "Pouzitie: $0:t -h -o <cislo> <cesta>"
            echo "          -h Help"
            echo "          -o <cislo> Obsadenost v percentach (zadavat ako cele cislo)"
            echo "          <cesta> cesta k suboru s datami"
            exit 1
        case -o:
            shift
            if(! $#argv) then
                echo "Za prepinacom -o musi nasledovat cislo" > /dev/stderr
                exit 1
                else
                    if (`echo $argv[1] | grep -E '^[0-9]+$'` == "") then
                        echo "Za prepinacom -o musi nasledovat cele kladne cislo" > /dev/stderr
                        exit 1
                        else
                            if ($argv[1] >= 0) then
                            @ obsadenost = $argv[1]
                            endif
                    endif
            endif
            breaksw
        case -*
            echo "Neznamy prepinac $argv[1]" > /dev/stderr
            exit 1
        default:
            breaksw; break
    endsw
    shift
end
if($#argv > 0) then
    set cesta = "$argv[1]"
endif

set databazy = (`grep -E '^mysql' $cesta | cut -d ' ' -f7 | tr -d '%'`)
set meno_databazy = ("`grep -E '^mysql' $cesta`")

@ i = 1
foreach riadok ($databazy)
    if($riadok > $obsadenost) then
        echo "$meno_databazy[$i]:q"
    endif
    @ i++
end
