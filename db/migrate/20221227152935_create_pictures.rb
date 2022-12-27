class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.string :title #t.データ型 :カラム名
      t.text :content #t.データ型 :カラム名
      t.timestamps
    end
  end
end
