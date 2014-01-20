class AddReleaseDateToEvent < ActiveRecord::Migration
  def up
    add_column :events, :release_date, :datetime
    Event.all.each { |e|
      e.release_date = e.created_at
      e.save!
    }
  end

  def down
    remove_column :events, :release_date
  end
end
