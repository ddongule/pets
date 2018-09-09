class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :kind
      t.string :color
      t.string :sex 
      t.string :age_weight
      t.string :happenPlace
      t.string :happenDate
      t.string :neuter
      t.text :character
      t.string :dog_number
      t.string :orgName
      t.string :processState
      t.string :careName
      t.string :careNumber
      t.string :carePlace
      t.string :image
    end
  end
end
