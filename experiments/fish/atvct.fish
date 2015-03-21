
function test_time
  set ftime $argv[1]
  set fhash $argv[2]
  set atc $argv[3]
  set ctc $argv[4]
  set ohash $argv[5]
  set commit_number $argv[6]
  test (math (printf "%s - %s" $ftime $atc)) -ne (math (printf "%s - %s" $ftime $ctc))
  and printf "$commit_number :: $fhash .. $ohash; ($ftime - $atc) != ($ftime - $ctc) => %s != %s\n" (math "$ftime - $atc") (math "$ftime - $ctc")
end

#:%s/\v^set -l \D*(\d+)\D*(\d+).{-} \.\. ([^;]*);.*/test_time $ftime $fhash \1 \2 \3/

set ftime (printf '%s' (glod -1 --pretty='%ct')) # 1425066087
set fhash (printf '%s' (glod -1 --pretty='%h')) # 5d3a4f1

# original was 200 of these
#
#   test_time $ftime $fhash 1425066087 1425066087 5d3a4f1 1
#
# now it's just this:

set indx 0
for a in (glod -200 --pretty='%at %ct %h')
  set indx (math "$indx + 1")
  #printf 'test_time %s %s %s %s => ' $ftime $fhash $a $indx
  eval (printf 'test_time %s %s %s %s' $ftime $fhash $a $indx)
end

