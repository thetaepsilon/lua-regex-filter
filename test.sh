#!/bin/sh

testdata="./testdata";
output="./gen/output";
p="./regexfilter";

comparefile() {
	diff "$1" "$2" >/dev/null;
	e=$?;
	if test $e -ne 0; then {
		echo "Output of test did not match expected!" >&2;
		echo "(failing files: $1 and $2)" >&2;
		exit $e;
	}; fi;
}

rm -rf "$output" || exit $?;
mkdir "$output" || exit $?;

t="01"
to="$output/test$t";
td="$testdata/$t"
mkdir "$to" || exit $?;
$p infile "$td/input" remainder file "$to/remainder" \
	match "^1" "$to/output1" \
	match "^2" "$to/output2" \
	match "^3" "$to/output3" \
	|| {
		e=$?;
		echo "$p terminated with exit code $e";
		exit $e;
	};
for i in output1 output2 output3 remainder; do {
	comparefile "$td/$i" "$to/$i";
}; done;



echo "All tests passing." >&2;
exit 0;
