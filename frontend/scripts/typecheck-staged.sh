files="";

# lint-staged will pass all files in $1 $2 $3 etc. iterate and concat.
for var in "$@"
do
    files="$files \"$var\","
done

# create temporary tsconfig which includes only passed files
str="{
  \"extends\": \"./tsconfig.json\",
  \"include\": [\"src/types/global.d.ts\",\"src/typings/window.ts\", \"src/typings/chartjs-adapter-date-fns.d.ts\", \"src/typings/environment.ts\" ,\"src/container/OnboardingContainer/typings.d.ts\",$files]
}"
echo $str > tsconfig.tmp

# run typecheck using temp config
tsc -p ./tsconfig.tmp

# capture exit code of tsc
code=$?

# delete temp config
rm ./tsconfig.tmp

exit $code
