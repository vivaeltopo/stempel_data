#! /bin/bash -l

FILENAME=index.md

echo "" > ${FILENAME}
echo "---" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "title:  \"Stencil detail\"" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "dimension    : \"EDIT_ME\"" >> ${FILENAME}
echo "radius       : \"EDIT_ME\"" >> ${FILENAME}
echo "weighting    : \"EDIT_ME\"" >> ${FILENAME}
echo "kind         : \"EDIT_ME\"" >> ${FILENAME}
echo "coefficients : \"EDIT_ME\"" >> ${FILENAME}
echo "datatype     : \"$(grep -m 1 "\[" size_10/Bench_stencil.txt | sed -e 's/ .*//')\"" >> ${FILENAME}
echo "machine      : \"$(basename $(head size_10/Bench_stencil.txt | grep "\-m" | sed -e 's/.*-m //'))\"" >> ${FILENAME}
echo "flavor       : \"EDIT_ME\"" >> ${FILENAME}
echo "comment      : \"EDIT_ME\"" >> ${FILENAME}
echo "compile_flags: \"icc $(grep "Executing (compile)" size_10/ECM_LC_stencil.txt | sed -e 's/.*icc //' -e 's/\.c.*/\.c/') -o stencil -llikwid" >> ${FILENAME}
echo "---" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture basename -%}" >> ${FILENAME}
echo "{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}" >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture source_code -%}" >> ${FILENAME}
if [ $(command -v clang-format) ]; then
clang-format -style="{BasedOnStyle: llvm, IndentWidth: 2, BreakBeforeBinaryOperators: None, ColumnLimit: 70, AlignOperands: true}" stencil.c >> ${FILENAME}
else
cat stencil.c >> ${FILENAME}
fi
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{%- capture layercondition -%}" >> ${FILENAME}
echo "$(tail -n 12 size_10/LC_stencil.txt | head -n 11 | sed -e '/layer condition/d')" >> ${FILENAME}
echo "{%- endcapture -%}" >> ${FILENAME}
echo "" >> ${FILENAME}
echo "{% include stencil_template.md %}" >> ${FILENAME}
