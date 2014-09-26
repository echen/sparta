class RenameChartBuildersToCharts < ActiveRecord::Migration
  def change
    rename_table :chart_builders, :charts
  end 
end
