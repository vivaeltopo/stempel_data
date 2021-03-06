{% if include.hidden == 'true' %}
	{% assign hide_if_hidden = 'style="display:none;"' %}
{% else %}
	{% assign hide_if_hidden = '' %}
{% endif %}
<div  markdown="1" class="roofline" id="rfl_{{include.type}}" {{hide_if_hidden}} >

{% if page.stencil_name %}
  {% capture csv_filename %}{{page.stencil_name}}_{{page.machine}}_results{% endcapture %}
{% else %}
  {% capture csv_filename %}{{page.dimension}}_{{page.radius}}_{{page.weighting}}_{{page.kind}}_{{page.coefficients}}_{{page.datatype}}_{{page.machine}}_results{% endcapture %}
{% endif %}

{% assign csv_file = site.data.stencils[{{csv_filename}}] %}

{% for data in csv_file %}
  {% assign N = data["N^3"] | append: ',' | prepend: N %}
  {% assign bench = data["Benchmark MLUPs"] | append: ',' | prepend: bench %}
  {% assign roofline_LC = data["Roofline LC MLUPs"] | append: ',' | prepend: roofline_LC %}
  {% assign roofline_CS = data["Roofline CS MLUPs"] | append: ',' | prepend: roofline_CS %}
  {% assign ecm = data["Roofline ECM MLUPs"] | append: ',' | prepend: ecm %}
{% endfor %}

<script>
var trace_benchmark = {
  type: "scatter",
  mode: "markers",
  marker: { symbol: "cross-thin-open" },
  x: [{{N}}],
  y: [{{bench}}],
  line: {color: 'black'},
  name: "Benchmark"
};
var trace_roofline = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{% if include.type == 'LC' %}{{roofline_LC}}{% elsif include.type == 'CS' %}{{roofline_CS}}{% endif %}],
  line: {color: '#1f77b4'},
  name: "Roofline prediction with {{include.type}}"
};
var trace_ecm = {
  type: "scatter",
  mode: "lines",
  x: [{{N}}],
  y: [{{ecm}}],
  line: {color: '#ff7f0e'},
  name: "ECM prediction with {{include.type}}"
};

var data = [trace_roofline,trace_ecm,trace_benchmark];

var layout = {
	xaxis: {title: "Grid Size (N^(1/{{page.dimension | replace: 'D', ''}}))",
          rangemode: "tozero"},
	yaxis: {title: 'Performance [MLUP/s]',
          rangemode: "tozero"},
  margin: { l: 50, r: 35, t: 10, b: 40},
  legend: { orientation: "h",y:1.1},
  width: 600,
  height: 450,
};

var config = {locale: 'en'};
Plotly.newPlot('rfl_{{include.type}}', data, layout, config);
</script>

*Performance plot with [roofline prediction](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2008/EECS-2008-164.html) in comparison with the measured stencil performance. For comparison the according ECM prediction is also included.*
</div>
