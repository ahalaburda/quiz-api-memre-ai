class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.text :question
      t.string :answer
      t.text :distractors

      t.timestamps
    end
  end
end
