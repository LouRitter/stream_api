require 'rails_helper'

RSpec.describe "Videos API", type: :request do
  let!(:videos) { create_list(:video, 5) } # Create test data
  let(:video_id) { videos.first.id }

  # Test GET /videos
  describe "GET /api/v1/videos" do
    before { get "/api/v1/videos" }

    it "returns videos" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
    
  # Test GET /videos/:id
  describe "GET /api/v1/videos/:id" do
    before { get "/api/v1/videos/#{video_id}" } # Ensure you're always using the defined `video_id`

    context "when the record exists" do
      it "returns the video" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(video_id)  # Check that the returned video has the same ID
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  
    context "when the record does not exist" do
      let(:video_id) { 100 } # If you want to test a non-existing ID
  
      before { get "/api/v1/videos/#{video_id}" } # Ensure that the request is sent with the invalid ID

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Video/)
      end
    end
  end

  # Test POST /videos
  describe "POST /api/v1/videos" do
    let(:valid_attributes) {{ video: attributes_for(:video) }}

    context "when the request is valid" do
      before { post "/api/v1/videos", params: valid_attributes }

      it "creates a video" do
        p json
        expect(json['title']).to eq('Sample Video Title')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) {{ video: attributes_for(:video).merge(title: nil) }}

      before { post "/api/v1/videos", params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body).to match("{\"title\":[\"can't be blank\"]}")
      end
    end
  end
end
