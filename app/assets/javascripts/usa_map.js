// wrap this in a closure like below otherwise var variables are global
$(document).ready(function() {
  if ($(".map").length > 0) {
    var width = 660,
        height = 380;

    var projection = d3.geo.albersUsa()
        .scale(800)
        .translate([width / 2, height / 2])

    var svg = d3.select(".map").append("svg")
        .attr("width", width)
        .attr("height", height);

    var path = d3.geo.path()
        .projection(projection);

    var g = svg.append("g");

    // as written, the function(error, us) callback won't fire until the d3.json finishes
    d3.json("json/usa_map.json", function(error, us) {
      g.selectAll("path")
        .data(us.features)
        .enter()
        .append("path")
        .attr("state", function(d) {
          return d.properties.NAME
        })
        .attr("d", path)
        var marks = [];
        $(".map").data("coordinates").forEach(function(coordinate) {
          marks.push(coordinate);
        })

        svg.selectAll(".mark")
            .data(marks)
            .enter()
            .append("image")
            .attr('class', function(d,i) { return "mark" + (i) })
            .attr('width', 20)
            .attr('height', 20)
            .attr("xlink:href","red_pin.png")
            .attr("transform", function(d) {return "translate(" + projection([d.longitude - 0.9, d.latitude + 1.2]) + ")";});
    });
  }
});
