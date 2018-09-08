class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :age
      t.string :careName
      t.string :color
      t.string :image
      t.integer :happenDate
      t.text :happenPlace
      t.string :kind
      t.string :neuter
      t.string :orgName
      t.string :processState

      t.timestamps
    end
  end
end
