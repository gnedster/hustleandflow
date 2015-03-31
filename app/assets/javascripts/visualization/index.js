$(document).ready(function() {
    var cal = new CalHeatMap();
    cal.init({
        data: gon.dateFrequency,
        tooltip: true,
        start: new Date(2011, 0),
        id : "cal-heatmap",
        domain : "month",
        subDomain : "day",
        range : 12,
    });

	//See gon variables in VisualizationController
	var nodes = _.values(gon.judges).concat(_.values(gon.donors)),
		links = _.map(gon.links, function(l) {
			return {
				source: gon.donors[l.source],
				target: gon.judges[l.target],
				value: l.value
			};
		}),
		width = 900,
		height = 900,
		color = d3.scale.ordinal().range(['#1f77b4', '#d62728']),
		lineWidth = d3.scale.linear().range([2, 10]).domain([0, gon.maxTotalValue]),
		circleRadius = d3.scale.linear().range([5, 50]).domain([0, gon.maxTotalValue]),
		force = d3.layout.force()
			.charge(-30)
			.linkDistance(30) //change these
		    .size([width, height]),
    	//finds chart div, creates svg element
	    svg = d3.select("#chart").append("svg")
                .attr("width", width)
		        .attr("height", height),
		link, node;

	link = svg.selectAll("line.link")
		.data(links)
		.enter().append("line")
		.attr("class", "link")
		.style("stroke-width", function(d) {
		    return lineWidth(d.value);
	    });

	node = svg.selectAll(".node")
		.data(nodes)
		.enter().append("g")
		.attr("class", "node")
		.call(force.drag);

	node.append("circle")
		.attr("r", function(d) {
			return circleRadius(d.totalValue);
		})
		.attr("group", function(d){
			return d.group;
		})
		.attr("total-value", function(d) {
    		return d.totalValue;
    	})
        .attr("gift-count", function(d) {
            return d.giftCount;
        })
		.attr("name", function(d) {
    		return d.name.titleize();
    	})
		.style("fill", function(d) {
		    return color(d.group);
	    })
        .style("cursor", "pointer")
        .on("click", function(d){
            window.location = d.url;
        });

    force.nodes(nodes)
        .links(links)
        .start();

	//Adding tipsy support
	$("svg circle").tipsy({
        gravity: "w",
        html: true,
        width: 400,
        title: function() {
        	function getActionWord() {
        		return el.attr("group") === "1" ? "Donated" : "Received";
        	}

        	function getNodeType() {
        		return el.attr("group") === "1" ? "Donor" : "Judge";
        	}

	        var el = $(this);

	        return [
	            "<h5>" + el.attr("name") + " (" + getNodeType() + ")</h5>",
	            "<table class='table table-condensed'>",
                "<tbody>",
                "<tr>",
	            "<td>Amount " + getActionWord() + ": </td>",
	            "<td>$" + el.attr("total-value") + "</td>",
                "</tr>",
                "<tr>",
                "<td>Number of Gifts " + getActionWord() + ": </td>",
                "<td>" + el.attr("gift-count") + "</td>",
                "</tr>",
                "</tbody>",
	            "</table>"
	            ].join('');
	        }
  		}
  	);

	force.on("tick", function() {
		link.attr("x1", function(d) {
			return d.source.x;
		})
			.attr("y1", function(d) {
			return d.source.y;
		})
			.attr("x2", function(d) {
			return d.target.x;
		})
			.attr("y2", function(d) {
			return d.target.y;
		});

		node.attr("transform", function(d) {
			return "translate(" + d.x + "," + d.y + ")";
		});
	});
});