class QuizzesSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :distractors
end
