gcc src/aux.c src/vendor/iota/* tests/test_ternary.c -lm -o test
chmod a+x test
echo "Running ternery test.."
./test
rm test
