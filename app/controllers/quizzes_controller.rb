require 'net/http'

class QuizzesController < ApplicationController
    #CREATE
    def create
      question = params[:question]
      answer = params[:answer]
  
      # Call Cerego API to fetch distractors
      distractors = fetch_distractors(question, answer)
  
      quiz_item = Quiz.create(question: question, answer: answer, distractors: distractors)
  
      render json: quiz_item, status: :created
    end
    #READ
    def show
      quiz_item = Quiz.find(params[:id])
      render json: quiz_item
    end
  
     #DELETE
    def destroy
      quiz_item = Quiz.find(params[:id])
      quiz_item.destroy
      head :no_content
    end

    private

    def fetch_distractors(question, answer)
      uri = URI.parse("https://stable.cerego.com/api/v4/suggested_distractors")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
    
      request = Net::HTTP::Get.new(uri.request_uri)
      request["Authorization"] = "Bearer 0oMI0uP8Pc1ZrR8sji+EqgQVPh3pVuF+tPGyAZaHz4hYO/wkcdEY7ijCdtL3028n"
      request.set_form_data({
        "question" => question,
        "texts[]" => answer
      })
    
      response = http.request(request)
    
      if response.code == "200"
        data = JSON.parse(response.body)
        distractors = data["data"]["attributes"]["distractors"].map { |distractor| distractor["text"] }
        return distractors
      else
        # Handle API error response
        return []
      end
    end
  end
  