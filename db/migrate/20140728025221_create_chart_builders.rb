class CreateChartBuilders < ActiveRecord::Migration
  def change
    create_table :chart_builders do |t|
      t.string :title
      t.string :creator
      t.text :description
      t.string :chart_type
      t.string :database
      t.text :sql_query
      t.string :x_column
      t.string :y_column
      t.string :grouping_column
      
      t.timestamps
    end 
  end
end
