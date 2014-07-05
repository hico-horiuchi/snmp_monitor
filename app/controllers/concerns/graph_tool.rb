module GraphTool
  def usage_graph( factor, title, usage, color )
    LazyHighCharts::HighChart.new('graph') do |f|
      f.chart type: 'pie', backgroundColor: 'transparent'
      f.plotOptions pie: { innerSize: '70%', colors: [color, '#222'], dataLabels: { enabled: false } }
      f.title text: title, verticalAlign: 'middle', floating: true, style: { color: 'white', font: 'bold 20px sans-serif' }
      f.series name: "#{factor} Usage", data: [['Busy', usage], ['Idle', 100 - usage]]
      f.legend enabled: false
      f.tooltip enabled: false
    end
  end
end
