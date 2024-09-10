XYChart testLineChart;
//XYChart CB_testLineChart

FloatList testLineChartX;
FloatList testLineChartY;

//1 setup
void graph_setup() {

testLineChart = new XYChart(this);
testLineChartX = new FloatList();
testLineChartY = new FloatList();

testLineChart.setData(testLineChartX.array(),testLineChartY.array());
//set range


//styling

}

//2 setup
