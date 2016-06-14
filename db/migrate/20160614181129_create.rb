class Create < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :type
      t.timestamps
    end

    create_table :owners do |t|
      t.string :name
      t.references :animal
    end
  end
end
