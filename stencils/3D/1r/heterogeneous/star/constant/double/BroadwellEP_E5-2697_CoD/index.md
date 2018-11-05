---

title:  "Stencil detail"

dimension    : "3D"
radius       : "1r"
weighting    : "heterogeneous"
kind         : "star"
coefficients : "constant"
datatype     : "double"
machine      : "BroadwellEP_E5-2697_CoD"
flavor       : ""
compile_flags: "icc -O3 -xCORE-AVX2 -fno-alias -qopenmp -DLIKWID_PERFMON -I/mnt/opt/likwid-4.3.2/include -L/mnt/opt/likwid-4.3.2/lib -I./stempel/stempel/headers/ ./stempel/headers/timing.c ./stempel/headers/dummy.c solar_compilable.c -o stencil -llikwid"
---

{%- capture basename -%}
{{page.dimension}}-{{page.radius}}-{{page.weighting}}-{{page.kind}}-{{page.coefficients}}-{{page.datatype}}-{{page.machine}}
{%- endcapture -%}

{%- capture source_code -%}
double a[M][N][P];
double b[M][N][P];
double c0;
double c1;
double c2;
double c3;
double c4;
double c5;
double c6;

for ( int k = 1; k < M-1; k++ ) {
	for ( int j = 1; j < N-1; j++ ) {
		for ( int i = 1; i < P-1; i++ ) {
			b[k][j][i] = c0 * a[k][j][i]
				+ c1 * a[k][j][i-1] + c2 * a[k][j][i+1]
				+ c3 * a[k-1][j][i] + c4 * a[k+1][j][i]
				+ c5 * a[k][j-1][i] + c6 * a[k][j+1][i];
		}
	}
}
{%- endcapture -%}

{%- capture layercondition -%}
L1: unconditionally fulfilled
L2: unconditionally fulfilled
L3: unconditionally fulfilled
L1: P <= 2050/3
L2: P <= 5462
L3: P <= 1179650/3
L1: 16*N*P + 16*P*(N - 1) <= 32768;32²
L2: 16*N*P + 16*P*(N - 1) <= 262144;90²
L3: 16*N*P + 16*P*(N - 1) <= 18874368;850²
{%- endcapture -%}

{% include stencil_template.md %}
