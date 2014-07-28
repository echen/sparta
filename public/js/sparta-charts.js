var sparta = sparta || {};

var convertIntoNvd3Format = function(data, config) {
  var grouped = null;
  if (typeof config.groupingColumn === 'undefined' || config.groupingColumn == '') {
    grouped = {data: data};
  } else {
    grouped = _.groupBy(data, function(d) {
      return d[config.groupingColumn];
    });
  }
  
  var groups = _.keys(grouped);
  var nvd3Data = _.map(groups, function(g) {
    var values = _.map(grouped[g], function(d) {
      return {x: d[config.xColumn], y: d[config.yColumn]};
    });
    return {key: g, values: values};
  });
  
  return nvd3Data;
};

sparta.makeBarChart = function(config) {
  var nvd3Data = convertIntoNvd3Format(config.data, config);
  
  nv.addGraph(function() {
    var chart = nv.models.discreteBarChart()
      .x(function(d) { return d.x })
      .y(function(d) { return d.y })
      .staggerLabels(true);

    d3.select(config.where)
      .datum(nvd3Data)
      .transition().duration(500)
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
};

sparta.makeTimeSeries = function(config) {
  var dateParsedData = jQuery.extend(true, {}, config.data);
  _.each(dateParsedData, function(d) {
    d[config.xColumn] = Date.parse(d[config.xColumn]);
  });
  var nvd3Data = convertIntoNvd3Format(dateParsedData, config);

  nv.addGraph(function() {
    var chart = nv.models.lineChart()
      .useInteractiveGuideline(true);

    chart.xAxis
      .axisLabel(config.xColumn)
      .tickFormat(function(d) {
        return d3.time.format('%x')(new Date(d))
      });

    chart.yAxis
      .axisLabel(config.yColumn);

    d3.select(config.where)
      .datum(nvd3Data)
      .transition().duration(500)
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
};

sparta.makeStackedTimeSeries = function(config) {
  var dateParsedData = jQuery.extend(true, {}, config.data);
  _.each(dateParsedData, function(d) {
    d[config.xColumn] = Date.parse(d[config.xColumn]);
  });
  var nvd3Data = convertIntoNvd3Format(dateParsedData, config);
  
  nv.addGraph(function() {
    var chart = nv.models.stackedAreaChart()
      .useInteractiveGuideline(true);

    chart.xAxis
      .axisLabel(config.xColumn)
      .tickFormat(function(d) {
        return d3.time.format('%x')(new Date(d))
      });

    chart.yAxis
      .axisLabel(config.yColumn);

    d3.select(config.where)
      .datum(nvd3Data)
      .transition().duration(500)
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
};

sparta.makeLineChart = function(config) {
  var nvd3Data = convertIntoNvd3Format(config.data, config);

  nv.addGraph(function() {
    var chart = nv.models.lineChart()
      .useInteractiveGuideline(true);

    chart.xAxis
      .axisLabel(config.xColumn);

    chart.yAxis
      .axisLabel(config.yColumn);

    d3.select(config.where)
      .datum(nvd3Data)
      .transition().duration(500)
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
};