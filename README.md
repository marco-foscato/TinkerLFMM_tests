# Tests for TinkerLFMM
This repository contains tests that allow to verify the correct behaviour of the Tinker/LFMM integration (see __TODO_add_link__).

## Usage
1. Clone/Download the repository.
2. Set the value of `TINKERLFMMBIN` by editing the beginning of file `run_tests.sh`. The value to use should be the pathname to the folder collecting the executables of a previously compiled TinkerLFMM package.
3. Run the tests by doing:
   ```
   ./run_tests.sh
   ```
   The tests should start and each outcome is analysed in detail. The results are reported under the `test/results_TinkerLFMM/` folder. The tests take about one hour to complete.
4. Analyse the results: `cd test/results_TinkerLFMM/`, if you can use [gnuplot](http://www.gnuplot.info/), you can run any of the following to build a plot with informative quantities:

```
gnuplot -persis plotGeomDiff_opt.gnu
gnuplot -persis plotGradComponents.gnu
gnuplot -persis plotGradDiff.gnu
gnuplot -persis plotGradDiff_relative.gnu
gnuplot -persis plotNrgDiff.gnu
gnuplot -persis plotNrgDiff_opt.gnu
gnuplot -persis plotNrgDiff_opt_relative.gnu
gnuplot -persis plotNrgDiff_relative.gnu
gnuplot -persis plotNrgDiff_relative_contribs.gnu
```

If you do not have `gnuplot`, you can still look or plot the results that are stored in the `test/results_TinkerLFMM/*.dat` files.
