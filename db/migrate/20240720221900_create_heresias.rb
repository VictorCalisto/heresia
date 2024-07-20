class CreateHeresias < ActiveRecord::Migration[7.1]
  def change
    create_table :heresias do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
