class AddQAndAExample < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string     :title
      t.text       :text
      t.string     :author
      t.timestamps
    end

    create_table :answers do |t|
      t.text       :text
      t.string     :author
      t.references :question
      t.timestamps
    end
  end
end
