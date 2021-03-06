FactoryBot.define do
  factory :note do
    message { "My important note" }
    association :project
    user { project.owner }

    #メッセージにfirstが入ったノート
    factory :note_first1 do
      message { "This is the first note." }
    end

    factory :note_first2 do
      message { "First,this is the third note." }
    end

    factory :with_attachment do
      attachment { Rack::Test::UploadFile.
        new("#{Rails.root}/spec/files/attachment.jpg", 'attachment.jpeg')}
    end

  end
end
