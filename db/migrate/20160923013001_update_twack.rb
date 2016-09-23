class UpdateTwack < ActiveRecord::Migration
	def up
		create_table :whacks do |t|
			t.string :first_word
			t.string :second_word
			t.integer :score
			t.integer :index
		end

	end

	def down
		drop_table :whacks
	end

end
