class CreateApiPets < ActiveRecord::Migration[5.1]
  def change
    create_table :api_pets do |t|
      t.string :image
      t.string :happenDt
      t.string :happenPlace
      t.string :kindCd
      t.string :colorCd
      t.string :age
      t.string :weight
      t.string :processState
      t.string :sexCd
      t.string :neuterYn
      t.string :specialMark
      t.string :careNm
      t.string :careAddr

      t.timestamps
    end
  end
end
